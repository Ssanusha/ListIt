class ApplicationController < ActionController::Base
  layout 'stores'
  before_filter :authorize, :except => [:login, :logout, :new, :create, :about, :show_forgot_password, :reset_forgot_password]
  helper :all
  # include all helpers, all the time
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store

  protect_from_forgery :secret => '8fc080370e56e929a2d5afca5540a0f7'
  # https://github.com/tscolari/mobylette
  #include Mobylette::RespondToMobileRequests
  protected

  def authorize
    unless User.find_by_id(session[:user_id])
      session[:original_uri] = request.url

      flash[:notice] = "Please log in"
      redirect_to :controller => 'system' , :action => 'login'
    end 
  end
  
end
