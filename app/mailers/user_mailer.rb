class UserMailer < ActionMailer::Base

  default :from => ENV["GMAIL_USERNAME"]
  ActionMailer::Base.delivery_method = :smtp

  ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => true,
    :address        => "smtp.gmail.com",
    :port           => 587,
    :domain         => "dev.mecocoon.com",
    :authentication => :plain,
    :user_name  => ENV["GMAIL_USERNAME"],
    :password  => ENV["GMAIL_PASSWORD"]

  }

  def welcome_email(user)

    @user = user
    @url  = "http://" +"#{ENV['LISTIT_URL']}" +"/stores"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end

  def share_email(sh)
    @share = sh
    @url  = "http://" +"#{ENV['LISTIT_URL']}" +"/stores"
    mail(:to => sh.share_email, :subject => "You have a new List Share.")
  end

  def share_with_account_email(sh)
    @share = sh
    @url  = "http://" +"#{ENV['LISTIT_URL']}" +"/stores"
    mail(:to => sh.share_email, :subject => "You have a new List Share.")
  end
  
  def forgot_password_email(user,newpass)

    @user = user
    @user.hashed_password = newpass
    @url  = "http://" +"#{ENV['LISTIT_URL']}" +"/system/login"
    mail(:to => user.email, :subject => "Your New Password")
  end
  
  def mail_me_my_list(list,email,store)
    @list = list
    @store = store
    @url  = "http://" +"#{ENV['LISTIT_URL']}" +"/stores"
    mail(:to => email, :subject => "Your todo list.")
  end
  
  def mail_me_share_list(list,share,store)
    @list = list
    @share = share
    @store = store
    @url  = "http://" +"#{ENV['LISTIT_URL']}" +"/system/login"
    mail(:to => share.share_email, :subject => "Your todo list.")
  end

end