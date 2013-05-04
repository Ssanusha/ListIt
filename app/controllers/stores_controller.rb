class StoresController < ApplicationController
  # GET /stores
  # GET /stores.json
  def show_item
    @store = Store.find(params[:id])
    @items = ListItem.find_list_items_for_store(params[:id])
    @newItem = ListItem.new

    if @items
      @listItem = @items
    else
      @listItem = ListItem.new
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stores }
    end
  end

  def add_item

    @store = Store.find(params[:id])
    @saveItem = ListItem.new(params[:list_item])
    li=ListItem.save_list_item(@saveItem,@store,session[:user_id])
    li.save
    #redirect_to_index
    respond_to do |format|
    #format.js
      format.html { redirect_to :action => 'show_item',:id => @store }
    end
  end

  def add_item_from_history

    @store = Store.find_store(params[:id])
    if @store.empty?
      newstore = Store.insert_new_store(params[:id],params[:store_name],session[:user_id])
    newstore.save
    end
    @fromhis = ItemHistory.find(params[:item_id])
    new = ListItem.save_item_from_history(@fromhis)

    new.save
    #redirect_to_index
    respond_to do |format|
    #format.js
      format.html { redirect_to :action => 'show_item',:id => @store }
    end
  end

  def delete_item
    @store = Store.find(params[:store_id])
    #ListItem.remove_item(params[:item_id])
    ListItem.destroy(params[:item_id])
    respond_to do |format|
      format.html { redirect_to :action => 'show_item',:id => @store }
    end
  end

  def show_history
    @day = params[:day]
    @itemhis=ItemHistory.new
    @itemhis = ItemHistory.show_item_from_history(session[:user_id],@day)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stores }
    end
  end

  def mail_list
    @store = Store.find(params[:id])
    @listItem = ListItem.find(params[:list])
    user_email = User.find(session[:user_id]).email
    UserMailer.mail_me_my_list(@listItem,user_email,@store).deliver
    respond_to do |format|
      flash[:notice]="This List has been emailed to you."
      format.html { redirect_to :action => 'show_item',:id => @store }
    end
  end

  def index
    #@stores = Store.all
    @stores = Store.find_store_for_user(session[:user_id])
    #@stores = Kaminari.paginate_array(@stores).page(params[:page]).per(3)
    @strcount = Hash.new
    @stores.each do |store|
      count = ListItem.get_item_count(store.id)
      #  Refer - http://www.ruby-doc.org/core-1.9.3/Hash.html
      #  move Hash.new before the for loop, otherwise it will re initialize
      #  everytime the loop is executed destroying previous content.
      #  I got this working, Check to see what is the difference between
      #  @ and no @. I think @ is pass by reference.

      @strcount[store.name] = count;
    #strcount["store"=>store, "count"=>count]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stores }
    end
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
    @store = Store.find(params[:id])

    respond_to do |format|
      format.html { redirect_to stores_url }
      format.json { render json: @store }
    end
  end

  # GET /stores/new
  # GET /stores/new.json
  def new
    @store = Store.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @store }
    end
  end

  # GET /stores/1/edit
  def edit
    @store = Store.find(params[:id])
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(params[:store])
    @store.user_id = session[:user_id]

    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
        format.json { render json: @store, status: :created, location: @store }
      else
        format.html { render action: "new" }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stores/1
  # PUT /stores/1.json
  def update
    @store = Store.find(params[:id])

    respond_to do |format|
      if @store.update_attributes(params[:store])
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destro
    @store = Store.find(params[:id])
    @store.destroy

    respond_to do |format|
      format.html { redirect_to stores_url }
      format.json { head :no_content }
    end
  end

  # REMOVE /stores/1
  # REMOVE /stores/1.json
  def remove
    @confirmation = true
    @myStore = Store.find(params[:id])
    @isItMystore = Store.find_if_my_store(session[:user_id],@myStore.id)
    @mySharedStore = Share.find_shared_store_for_delete(session[:user_id],@myStore.id)
    if @isItMystore.empty?
      @confirmation = false
      flash[:alert]="This is a store which has been shared with you. Thus cannot be deleted"
    else
      @myStore.destroy
      @mySharedStore.delete(1)
      @confirmation = true
      flash[:notice]="Store deleted."
    end

    respond_to do |format|
      format.html { redirect_to stores_url }
      format.json { head :no_content }
    end
  end

end
