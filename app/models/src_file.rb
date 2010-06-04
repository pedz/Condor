class SrcFile < SCM::CMVC
  def self.find(options, user)
    logger.info("hi from SrcFile")
    find_cmvc_id(user) unless (user.cmvc && !user.cmvc.blank?)
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
      logger.info("stderr = #{cmd_result.stderr}")
      raise SCM::PopenFailed.new(string, cmd_result.exit_status, cmd_result.stderr)
    end
    cmd_result.stdout
  end

  private
  
  def self.find_cmvc_id(user)
    raise SCM::NoLDAP.new unless ldap = user.ldap # should never happen
    raise SCM::NoUID.new unless uid = ldap.uid
    logger.info("uid for #{user.ldap_id} is #{uid}")
    string = "/usr/local/cmvc/bin/Report \
                -family aix \
                -become pedzan \
                -general 'UserView' \
                -where \"ccnum = '#{uid}'\" \
                -select login"
    cmd_result = popen(string)
    if cmd_result.exit_status != 0
      logger.info("stderr = #{cmd_result.stderr}")
      raise SCM::PopenFailed.new(string, cmd_result.exit_status, cmd_result.stderr)
    end
    login = cmd_result.stdout[0].chomp
    if login.blank?
      raise SCM::LoginNotFound.new
    end
    if user.cmvc
      user.cmvc.destroy
    end
    user.cmvc.create! :login => login
  end
end
