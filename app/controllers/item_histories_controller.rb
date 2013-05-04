class ItemHistoriesController < ApplicationController
  # GET /item_histories
  # GET /item_histories.json
  
  def bag_item
    @listItem = ListItem.find(params[:item_id])
    @item_history = ItemHistory.new(params[:item_history])
    hi=@item_history.save_item_to_history(@listItem)
    hi.save
    @listItem.destroy
    respond_to do |format|
      format.html { redirect_to(:controller => "stores", :action => "show_item", :id => @listItem.stores_id) }
    end
  end
  
  def index
    @item_histories = ItemHistory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @item_histories }
    end
  end

  # GET /item_histories/1
  # GET /item_histories/1.json
  def show
    @item_history = ItemHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item_history }
    end
  end

  # GET /item_histories/new
  # GET /item_histories/new.json
  def new
    @item_history = ItemHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item_history }
    end
  end

  # GET /item_histories/1/edit
  def edit
    @item_history = ItemHistory.find(params[:id])
  end

  # POST /item_histories
  # POST /item_histories.json
  def create
    @item_history = ItemHistory.new(params[:item_history])

    respond_to do |format|
      if @item_history.save
        format.html { redirect_to @item_history, notice: 'Item history was successfully created.' }
        format.json { render json: @item_history, status: :created, location: @item_history }
      else
        format.html { render action: "new" }
        format.json { render json: @item_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /item_histories/1
  # PUT /item_histories/1.json
  def update
    @item_history = ItemHistory.find(params[:id])

    respond_to do |format|
      if @item_history.update_attributes(params[:item_history])
        format.html { redirect_to @item_history, notice: 'Item history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_histories/1
  # DELETE /item_histories/1.json
  def destroy
    @item_history = ItemHistory.find(params[:id])
    @item_history.destroy

    respond_to do |format|
      format.html { redirect_to item_histories_url }
      format.json { head :no_content }
    end
  end
end
