class FileChange
  attr_reader :release, :defect, :level, :sccsid, :path, :type, :reference
  attr_reader :abstract, :prev_sccsid

  def initialize(release, defect, level, sccsid, path, type, reference,
                 prev_sccsid, abstract)
    @release = release
    @defect = defect
    @level = level
    @sccsid = sccsid
    @path = path
    @type = type
    @reference = reference
    @abstract = abstract
    @prev_sccsid = prev_sccsid unless prev_sccsid.empty?
  end

  def self.find(file)
    changes = []
    IO.popen("/usr/local/cmvc/bin/Report \
               -family aix \
               -become pedzan \
               -general \"Changes c, \
		 Defects d, \
		 Files f, \
		 Path p, \
		 Tracks t, \
		 Levels l, \
		 Releases r, \
		 Versions v, \
                 Versions prev \
		 \" \
       -where \" \
                 f.basename = '#{file}' and \
		 f.id = c.fileid and \
		 c.trackid = t.id and \
		 d.id = t.defectid and \
		 f.pathid = p.id and \
		 t.releaseid = r.id and \
		 v.id = c.versionid and \
                 prev.id = v.previousId and \
                 l.id in ( \
		          select l.id \
                          from   Levels l, \
                                 LevelMembers lm \
                          where  lm.trackid = t.id and \
                                 l.id = lm.levelid and \
                               ( l.type = 'published' or \
                                 ( l.type = 'production' and \
                                   not exists ( \
                                       select * \
                                       from Levels l, \
                                            LevelMembers lm \
                                       where l.id = lm.levelid and \
                                             l.type = 'published' and \
                                             t.id = lm.trackid ) \
                                 ) \
                               ) \
                        union \
		          select l.id \
                          from   Levels l, \
                                 LevelMembers lm \
                          where  l.name is null and \
                                 not exists ( \
				     select * \
                                     from  Levels l, \
                                           LevelMembers lm \
                                     where l.id = lm.levelid and \
                                           l.type in ( 'production', \
                                                       'published' ) and \
                                           t.id = lm.trackid ) \
                        ) \
                 order by path, rname, c.versionId \
	       \" \
       -select \"\
	        r.name as rname, \
	        d.name, \
		l.name, \
		v.SID as sccsid, \
		p.name as path, \
		c.type, \
		d.reference, \
                prev.SID as prev_sccsid, \
		d.abstract \
                \"") do |io|
      io.each_line do |line|
        line.chomp!
        RAILS_DEFAULT_LOGGER.debug("line is #{line}")
        changes << new(*line.split(/\|/, 9))
      end
    end
    changes
  end
end
