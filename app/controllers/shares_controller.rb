class SharesController < ApplicationController
  def show_share_item
    @store = Store.find(params[:id])
    @items = ListItem.find_list_items_for_store(params[:id])
    @newShare = Share.new
    @share = Share.find_share_for_store(params[:id])
    @show = params[:show]
    
    if @items
      @listItem = @items
    else
      @listItem = ListItem.new
    end

    if @share
      @shareList = @share
    else
      @shareList = Share.new
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stores }
    end
  end

  def add_share_item
    @store = Store.find(params[:id])
    puts "STORE OBJECT : #{@store}"
    @saveShare = Share.new(params[:share])
    puts "SHARE OBJECT : #{@saveShare}"
    @user = User.find(session[:user_id])
    puts "USER OBJECT : #{@user}"

    @findUser = User.find_user_with_email(@saveShare.share_email)
    tmpUser ='';
    @findUser.each do |newUser|
      tmpUser = newUser
    end

    if @findUser.blank?
      #Generate a 4 character long password for the new user
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      newpass = ""
      1.upto(4) { |i| newpass << chars[rand(chars.size-1)] }
      us = User.save_new_user(newpass,@saveShare)
      us.save
      us.hashed_password = newpass
      UserMailer.welcome_email(us).deliver
      
      shn=Share.save_share_with_new_user(@saveShare,@store,@user,us)
      UserMailer.share_email(shn).deliver
    shn.save
    else
      sh = Share.save_share(@saveShare,@store,@user,tmpUser)
      UserMailer.share_email(sh).deliver
      sh.save
    end
    #redirect_to_index
    respond_to do |format|
    #format.js
      format.html { redirect_to :action => 'show_share_item',:id => @store }
    end
  end

  def delete_share
    #@share = Share.find(params[:share_id])
    #ListItem.remove_item(params[:item_id])
    Share.destroy(params[:id])
    flash.now[:alert] = "Share deleted successfully."
    redirect_to(:action => "index")

#    respond_to do |format|
 #     format.html { redirect_to :action => 'index'}
    #end
  end
  
  
  def mail_list
    @store = Store.find(params[:id])
    @listItem = ListItem.find(params[:list])
    @share = Share.find(params[:share])
    UserMailer.mail_me_share_list(@listItem,@share,@store).deliver
    respond_to do |format|
      flash[:notice]="This List has been emailed to you."
      format.html { redirect_to :action => 'show_share_item',:id => @store }
    end
  end
  
  

  # GET /shares
  # GET /shares.json
  def index
    #@shares = Share.all
    @stores = Store.find_my_stores(session[:user_id])
    @sharedStores = Store.find_my_share_stores(session[:user_id])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shares }
    end
  end

  # GET /shares/1
  # GET /shares/1.json
  def show
    @share = Share.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @share }
    end
  end

  # GET /shares/new
  # GET /shares/new.json
  def new
    @share = Share.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @share }
    end
  end

  # GET /shares/1/edit
  def edit
    @share = Share.find(params[:id])
  end

  # POST /shares
  # POST /shares.json
  def create
    @share = Share.new(params[:share])

    respond_to do |format|
      if @share.save
        format.html { redirect_to @share, notice: 'Share was successfully created.' }
        format.json { render json: @share, status: :created, location: @share }
      else
        format.html { render action: "new" }
        format.json { render json: @share.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shares/1
  # PUT /shares/1.json
  def update
    @share = Share.find(params[:id])

    respond_to do |format|
      if @share.update_attributes(params[:share])
        format.html { redirect_to @share, notice: 'Share was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @share.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shares/1
  # DELETE /shares/1.json
  def destroy
    @share = Share.find(params[:id])
    @share.destroy

    respond_to do |format|
      format.html { redirect_to shares_url }
      format.json { head :no_content }
    end
  end
end
