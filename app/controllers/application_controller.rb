# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '1013262db980fe9f93abcc048a66e7de'

  unless defined?(HERE)
    before_filter :authenticate 
    HERE = 1
  end

  # For development mode, we do not do the authentication with
  # Bluepages
  unless defined? NONE_AUTHENTICATE
    NONE_AUTHENTICATE = File.exists?(RAILS_ROOT + "/config/no_ldap")
  end

  rescue_from SCM::LoginRequired, :with => :login_required
  rescue_from SCM::PopenFailed,   :with => :popen_failed
  rescue_from SCM::NoLDAP,        :with => :no_ldap_failure
  rescue_from SCM::NoUID,         :with => :no_ldap_uid
  rescue_from SCM::LoginNotFound, :with => :scm_login_not_found

  # Return true if current user is an administrator of the site
  def admin?
    application_user.admin
  end
  helper_method :admin?

  # I'm scared to use "user" so I'm going with "application_user".
  # I keep user_id in the session.
  def application_user
    if @application_user.nil?
      # logger.debug("@application_user is nil")
      if session.has_key?(:user_id)
        # logger.debug("session[:user_id] set to #{session[:user_id]}")
        tmp = User.find(:first, :conditions => { :id => session[:user_id]})
        if tmp.nil?
          # logger.debug("Did not find user id #{session[:user_id]}")
          reset_session
        else
          logger.info("Request for #{tmp.ldap_id}")
          @application_user = tmp
        end
      end
    end
    @application_user
  end
  helper_method :application_user

  # A before_filter for the entire application.  This authenticates
  # against bluepages.  If authentication succeeds, the matching user
  # record is found.  If it does not exist, it is created and
  # initialized with the ldap_id field.  The user model is stored in
  # the session.
  def authenticate
    # logger.debug("APP: authorization: #{temp_debug(request)}")
    set_last_uri
    return true unless application_user.nil?
    # logger.info("Header NOT-SET = #{request.headers['NOT-SET'].inspect}")
    if request.env.has_key? "REMOTE_USER"
      logger.info("REMOTE_USER = #{request.env["REMOTE_USER"]}")
      apache_authenticate
    elsif request.headers.has_key?('HTTP_X_FORWARDED_USER')
      logger.info("Header HTTP_X_FORWARDED_USER = #{request.headers['HTTP_X_FORWARDED_USER']}")
      proxy_apache_authenticate
    elsif Rails.env == "test"
      logger.info("Authenticate via test")
      testing_authenticate
    elsif NONE_AUTHENTICATE
      logger.info("Authenticate via none")
      none_authenticate
    else
      ldap_authenticate
    end
  end

  # This may not be used anywhere in Condor.
  def set_last_uri
    env = request.env
    last_uri = session[:last_uri]
    uri =  env["REQUEST_URI"]
    logger.info("last_uri = #{last_uri}, uri = #{uri}")

    cache_control = request.cache_control
    # logger.debug("APP: cache_control: #{cache_control.inspect}")

    # Note: We look at the cache-control HTTP header.  If it says,
    # 'no-cache', then we do a full refresh.  A "full-refresh" means
    # that we do not trust the state of a queue or the state of a PMR
    # without checking its last modification date.
    if cache_control.is_a? String
      @no_cache = cache_control == "no-cache"
    elsif cache_control.is_a? Array
      @no_cache = cache_control.include?("no-cache")
    else
      @no_cache = false
    end
    logger.info("APP: no_cache = #{@no_cache}")
    session[:last_uri] = uri
  end

  # This authenticates against bluepages using LDAP.
  def ldap_authenticate
    # logger.debug("ldap_authenticate")
    # ldap_time = Benchmark.realtime { ActiveLdap::Base.setup_connection }
    # logger.debug("LDAP: took #{ldap_time} to establish the connection")
    authenticate_or_request_with_http_basic "Bluepages Authentication" do |user_name, password|
      logger.info("attempt to ldap authenticate: user_name #{user_name}")
      next nil unless LdapUser.authenticate_from_email(user_name, password)
      logger.info("successful ldap_authenticate as #{user_name}")
      common_authenticate(user_name)
      return true
    end
    return false
  end

  # No authentication although an http basic authentication sequence
  # still occurs
  def none_authenticate
    authenticate_or_request_with_http_basic "Raptor" do |user_name, password|
      logger.debug("none_authenticate as #{user_name}")
      common_authenticate(user_name)
      return true
    end
    return false
  end

  # Apache has already authenticated so let the user in.
  def apache_authenticate
    logger.info("apache_authenticate as #{request.env["REMOTE_USER"]}")
    common_authenticate(request.env["REMOTE_USER"])
    return true
  end

  # Apache has already authenticated but we are behind a proxy so use
  # HTTP_X_FORWARDED_USER instead
  def proxy_apache_authenticate
    logger.info("proxy_apache_authenticate as #{request.env["HTTP_X_FORWARDED_USER"]}")
    common_authenticate(request.headers["HTTP_X_FORWARDED_USER"])
    return true
  end

  def testing_authenticate
    logger.info("testing_authenticate")
    common_authenticate('pedzan@us.ibm.com')
    return true
  end

  # Common set up steps in the authentication process After
  # authentication succeeds, the matching user record is found.  If it
  # does not exist, it is created and initialized with the ldap_id
  # field.  The user model is stored in the session.
  def common_authenticate(user_name)
    user = User.find_by_ldap_id(user_name)
    if user.nil?
      user = User.new
      user.ldap_id = user_name
      user.save!
    end
    session[:user_id] = user.id
  end
  
  def temp_debug(request)
    request.env['HTTP_AUTHORIZATION']   ||
      request.env['X-HTTP_AUTHORIZATION'] ||
      request.env['X_HTTP_AUTHORIZATION'] ||
      request.env['REDIRECT_X_HTTP_AUTHORIZATION']
  end

  def login_required(exception)
    session[:original_uri] = request.request_uri
    flash[:error] =
      "A CMVC id is required for source code access<br/>
       Due to security and access concerns, Condor uses your CMVC id
       to access CMVC.  Enter your CMVC id below.  You also need to
       execute a <q>Host -create</q> command for the hosts that Condor
       makes requests from.<br/>
       The exact command needed should be printed for you on the next page."
    redirect_to edit_user_url(application_user)
  end

  def popen_failed(exception)
    @exception = exception
    render "scm/popen_failed.html", :layout => "scm"
  end

  def no_ldap_failure(exception)
    @exception = exception
    render "scm/no_ldap_failure", :layout => "scm"
  end

  def no_ldap_uid(exception)
    @exception = exception
    render "scm/no_ldap_uid", :layout => "scm"
  end

  def scm_login_not_found(exception)
    @exception = exception
    render "scm/scm_login_not_found", :layout => "scm"
  end
end
