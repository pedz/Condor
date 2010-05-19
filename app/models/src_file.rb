class SrcFile < SCM::CMVC
  def self.find(options, user)
    logger.debug("hi")
    raise SCM::LoginRequired.new unless (user.cmvc && !user.cmvc.blank?)
    string = "/usr/local/cmvc/bin/File \
                -extract #{options[:path]} \
                -release #{options[:release]} \
                -version #{options[:version]} \
                -family aix \
                -become #{user.cmvc.login} \
                -stdout"
    cmd_result = popen(string)
    if cmd_result.exit_status != 0
      raise SCM::PopenFailed.new(cmd_result.exit_status, cmd_result.stderr)
    end
    cmd_result.stdout
  end
end
