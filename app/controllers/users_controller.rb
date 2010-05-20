class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    if admin?
      @users = User.find(:all)
    else
      @users = [ application_user ]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @user.cmvc = Cmvc.new unless @user.cmvc
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    if admin?
      @user.admin = params[:user][:admin]
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html {
          uri = session[:original_uri]
          session[:original_uri] = nil
          redirect_to(uri || @user)
        }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
end
