# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class SrcFile < SCM::CMVC
  def self.find(options, user)
    logger.info("hi from SrcFile")
    find_cmvc_id(user) unless (user.cmvc && user.cmvc.login && !user.cmvc.login.blank?)
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
                -where \"( ccnum = '#{uid.downcase}' OR ccnum = '#{uid}' ) AND dropDate IS NULL\" \
                -select login"
    cmd_result = popen(string)
    if cmd_result.exit_status != 0
      logger.info("stderr = #{cmd_result.stderr}")
      raise SCM::PopenFailed.new(string, cmd_result.exit_status, cmd_result.stderr)
    end
    
    if cmd_result.stdout.empty? ||
        cmd_result.stdout[0].nil? ||
        (login = cmd_result.stdout[0].chomp).nil? ||
        login.blank?
      raise SCM::LoginNotFound.new
    end
    if user.cmvc
      user.cmvc.update_attributes({ :login => login })
    else
      c = Cmvc.create :login => login
      user.cmvc = c
      user.save
    end
  end
end
