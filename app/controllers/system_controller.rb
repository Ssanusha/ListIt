class SystemController < ApplicationController
  def login
    if request.post?
      puts params[:email]
      @user = User.authenticate(params[:email], params[:hashed_password])
      if @user
        session[:user_id] = @user.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        #not implemented below for remember password
        #cookies.permanent[:auth_token] = generate_token
        # The below is here to display the name inside the app
        session[:name] = @user.name
        session[:profile_pic_url] = @user.avatar.url(:thumb)
        #redirect_to(:controller => "stores", :action => "index")
        respond_to do |format|
          #format.html {redirect_to(:controller => "stores", :action => "index")}
          format.html {redirect_to stores_path}
          @user.hashed_password = nil
          @user.salt = nil
          format.xml  { render :xml => @user }
          format.json { render :json => @user }
        end
      else
        flash.now[:alert] = "Invalid login/password combination"
        respond_to do |format|
          format.html #do the default routing to the view
          format.json {render :json => {:code => '01', :message => 'Invalid login/password combination'}.to_json }
          format.xml {render :xml => {:code => '01', :message => 'Invalid login/password combination'}.to_json }
        end
      end
    end
  end

  def new
    redirect_to(:controller => "users", :action => "new")
  end

  def logout
    #not implemented below for remember password
    #cookies.delete(:auth_token)
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login" )
  end

  def index

  end

  def about

  end

  def generate_token
    SecureRandom.urlsafe_base64
  end

  def show_forgot_password
    @holderUser = User.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def reset_forgot_password
    @user = User.new
    @formUser = User.new(params[:user])
    if params[:user]['email'].blank?
      flash[:alert] = "Please enter your registered email id to reset your password."
      redirect_to(:action => "show_forgot_password" )
    else
    #Create a new password
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      newpass = ""
      1.upto(6) { |i| newpass << chars[rand(chars.size-1)] }
      @fpuser = User.find_user_with_email(params[:user]['email'])

      tmpUser ='';
      @fpuser.each do |newUser|
        @user = newUser
      end
      if @fpuser.blank?
        flash[:alert] = "We are unable to find your account in the system. Please check your email id and retry."
        redirect_to(:action => "show_forgot_password" )
      else
        new_encrypted_password = User.encrypted_password(newpass,@user.salt)
        #@user.update_attributes(params[:model])

        User.reset_password(@user.id,new_encrypted_password);
        UserMailer.forgot_password_email(@user,newpass).deliver
        flash[:notice] = "Password reset successful. Check your email for details."
        redirect_to(:action => "login")

      end

    end
  end
end
