class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.find(:all, :order => :username)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])

  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        flash[:notice] = "User #{@user.username} was successfully created."
        format.html { redirect_to(:action => 'index') }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        #flash[:notice] = "User #{@user.username} was successfully updated."
        #format.html { redirect_to(:action => 'index') }
        session[:profile_pic_url] = @user.avatar.url(:thumb)
        flash[:notice] = "#{@user.username}, your profile picture was changed successfully."
        format.html {redirect_to(:controller => "users", :action => "show_profile", :id=>session[:user_id])}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    begin
      @user.destroy
      flash[:notice] = "User #{@user.username} deleted"
    rescue Exception => e
      flash[:notice] = e.message
    end

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def show_profile
    @user = User.find(params[:id])
  end

  def save_change_password
    # do password confirmation validation
    @passuser = User.new(params[:user])
    if @passuser.password == ''
      flash[:alert] = "Please enter the New Password."
    else
      if @passuser.password == @passuser.password_confirmation

        @user = User.find(session[:user_id])
        @authUser = User.authenticate(@user.email, params[:user][:current_password])
        if @authUser

          new_encrypted_password = User.encrypted_password(@passuser.password,@user.salt)
          User.update(@user.id, {:hashed_password=>new_encrypted_password});
          flash[:notice] = "Password successfully changed."

        else
          flash[:alert] = "Current password does not match. Please retry."
        end

      else
        flash[:alert] = "New Password and Confirm Password don't match. Please try again.."
      end
    end
    redirect_to(:controller => "users", :action => "show_profile", :id=>session[:user_id])
  end

end
