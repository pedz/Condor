
class DiffsController < ApplicationController
  def show
    @new_params = {
      :release => params[:release],
      :version => params[:version],
      :path => params[:path].join('/')
    }
    @old_params = find_prev_version(@new_params)
    @old_file = SrcFile.find(@old_params, application_user)
    @new_file = SrcFile.find(@new_params, application_user)

    @mc = MyCallbacks.new
    @bal = Diff::LCS.traverse_balanced(@old_file, @new_file, @mc)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @apar }
    end
  end

  private

  def find_prev_version(params)
    p = { }
    IO.popen("
/usr/local/cmvc/bin/Report \
       -family aix \
       -become pedzan \
       -general \" \
         Versions v, \
         Versions prev_v, \
         Path p, \
         Path prev_p, \
	 Changes c, \
	 Changes prev_c, \
	 Releases r, \
	 Releases prev_r, \
         Files f, \
	 Files prev_f \
                \" \
       -where \" \
	 r.name = '#{params[:release]}' and \
         p.name = '#{params[:path]}' and \
	 v.SID = '#{params[:version]}'  and \
	 c.pathId = p.id and \
	 c.fileId = f.id and \
	 c.versionId = v.id and \
	 f.pathId = p.id and \
	 f.releaseId = r.id and \
	 v.previousId = prev_v.id and \
	 prev_v.id = prev_c.versionId and \
	 prev_c.pathId = prev_p.id and \
	 prev_c.fileId = prev_f.id and \
	 prev_f.releaseId = prev_r.id and \
	 r.name >= prev_r.name \
	 ORDER BY prev_r.name DESC \
	 FETCH FIRST 1 ROW ONLY \
              \" \
       -select \" \
	 prev_r.name as release, \
	 prev_p.name as path, \
	 prev_v.SID as sccsid \
               \"
                     ") do |io|
      if line = io.gets
        line.chomp!
        p[:release], p[:path], p[:version] = line.split(/\|/)
      end
    end
    p
  end

end
