class SrcFile
  def self.find(options)
    raise "CMVC Login Required" unless (application_user.cmvc && !application_user.cmvc.blank?)
    lines = []
    string = "/usr/local/cmvc/bin/File \
                -extract #{options[:path]} \
                -release #{options[:release]} \
                -version #{options[:version]} \
                -family aix \
                -become #{application_user.cmvc.login} \
                -stdout"
    puts(string)
    IO.popen(string) do |io|
      lines = io.readlines
    end
    lines
  end
end
