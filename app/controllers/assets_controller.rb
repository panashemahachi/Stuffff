class AssetsController < ApplicationController
  before_action :set_asset, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /assets
  # GET /assets.json
  def index
    #@assets = current_user.assets

    if params[:search]
      @assets = Asset.where(:user_id => current_user.id).search(params[:search]).order("created_at DESC")

    if user_signed_in? 
      @assets = current_user.assets.order("uploaded_file_file_name desc")       
    end
  end
end
  # GET /assets/1
  # GET /assets/1.json
  def show
  end

  # GET /assets/new
  def new
    @asset = current_user.assets.build

    #upload file into a folder
    if params[:folder_id] 
      @current_folder = current_user.folders.find(params[:folder_id]) 
      @asset.folder_id = @current_folder.id 
      end 
  end

  # GET /assets/1/edit
  def edit
  end

  # POST /assets
  # POST /assets.json
  def create
    @asset = current_user.assets.build(asset_params)
=begin
    respond_to do |format|
      if @asset.save
        format.html { redirect_to @asset, notice: 'Asset was successfully created.' }
        format.json { render :show, status: :created, location: @asset }
      else
        format.html { render :new }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
=end
  
  if @asset.save
    flash[:notice] = "Successfully uploaded file"

    # If in parent folder
    if @asset.folder
      redirect_to browse_path(@asset.folder)
    else
      # Ensure redirected to correct url
      redirect_to root_url
    end
  else
    render :action => 'new'
  end

  end

  # PATCH/PUT /assets/1
  # PATCH/PUT /assets/1.json
  def update
    respond_to do |format|
      if @asset.update(asset_params)
        format.html { redirect_to @asset, notice: 'Asset was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset }
      else
        format.html { render :edit }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy

    @parent_folder = @asset.folder
    @asset.destroy
    flash[:notice] = "Successfully deleted file"

    if @parent_folder
      redirect_to browse_path(@parent_folder)
    else
      redirect_to root_url
    end
=begin
    respond_to do |format|
      format.html { redirect_to assets_url, notice: 'Asset was successfully destroyed.' }
      format.json { head :no_content }
    end
=end
  end

  def get
    asset = current_user.assets.find_by_id(params[:id])
    if asset
      data = open(URI.parse(URI.encode(asset.uploaded_file.url)))

      send_data data, :filename => asset.uploaded_file_file_name
      #send_file asset.uploaded_file.url, :type => asset.uploaded_file_content_type
    else
      flash[:error] = "Wait, this isn't your file..."
      redirect_to root_url
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset
      @asset = current_user.assets.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asset_params
      params.require(:asset).permit(:user_id, :uploaded_file)
    end
end
