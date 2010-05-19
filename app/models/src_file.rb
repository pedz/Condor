class SrcFile < SCM::SMVC
  def self.find(options, user)
    logger.debug("hi")
    raise "CMVC Login Required" unless (user.cmvc && !user.cmvc.blank?)
    lines = []
    string = "/usr/local/cmvc/bin/File \
                -extract #{options[:path]} \
                -release #{options[:release]} \
                -version #{options[:version]} \
                -family aix \
                -become #{user.cmvc.login} \
                -stdout"
    IO.popen(string) do |io|
      lines = io.readlines
    end
    lines
  end
end
