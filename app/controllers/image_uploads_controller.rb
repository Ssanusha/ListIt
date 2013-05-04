class ImageUploadsController < ApplicationController
  # GET /image_uploads
  # GET /image_uploads.json
  def index
    @image_uploads = ImageUpload.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @image_uploads }
    end
  end

  # GET /image_uploads/1
  # GET /image_uploads/1.json
  def show
    @image_upload = ImageUpload.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image_upload }
    end
  end

  # GET /image_uploads/new
  # GET /image_uploads/new.json
  def new
    @image_upload = ImageUpload.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image_upload }
    end
  end

  # GET /image_uploads/1/edit
  def edit
    @image_upload = ImageUpload.find(params[:id])
  end

  # POST /image_uploads
  # POST /image_uploads.json
  def create
    @image_upload = ImageUpload.new(params[:image_upload])

    respond_to do |format|
      if @image_upload.save
        format.html { redirect_to @image_upload, notice: 'Image upload was successfully created.' }
        format.json { render json: @image_upload, status: :created, location: @image_upload }
      else
        format.html { render action: "new" }
        format.json { render json: @image_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /image_uploads/1
  # PUT /image_uploads/1.json
  def update
    @image_upload = ImageUpload.find(params[:id])

    respond_to do |format|
      if @image_upload.update_attributes(params[:image_upload])
        format.html { redirect_to @image_upload, notice: 'Image upload was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_uploads/1
  # DELETE /image_uploads/1.json
  def destroy
    @image_upload = ImageUpload.find(params[:id])
    @image_upload.destroy

    respond_to do |format|
      format.html { redirect_to image_uploads_url }
      format.json { head :no_content }
    end
  end
end
