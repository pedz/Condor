class Change
  attr_reader :release, :defect, :level, :sccsid, :path, :type, :reference, :abstract, :prev_sccsid

  def initialize(release, defect, level, sccsid, path, type, reference, abstract, prev_sccsid = nil)
    @release = release
    @defect = defect
    @level = level
    @sccsid = sccsid
    @path = path
    @type = type
    @reference = reference
    @abstract = abstract
    @prev_sccsid = prev_sccsid
  end

  def self.find(defect)
    changes = []
    IO.popen("/usr/contrib/bin/Report \
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
		 d.name = '#{defect}' and \
		 d.id = t.defectid and \
		 c.trackid = t.id and \
		 f.id = c.fileid and \
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
                                       from   Levels l, \
                                              LevelMembers lm \
                                       where  l.id = lm.levelid and \
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
    order by defect, release, path, sccsid \
	       \" \
       -select \"\
	        r.name as release, \
	        d.name as defect, \
		l.name as level, \
		v.SID as sccsid, \
		p.name as path, \
		c.type, \
		d.reference, \
		d.abstract, \
		prev.SID as prev_sccsid \
                ") do |io|
      io.each_line do |line|
        line.chomp!
        RAILS_DEFAULT_LOGGER.debug("line is #{line}")
        changes << new(*line.split(/\|/))
      end
    end
    changes
  end
end
