class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :update, :destroy]
  before_filter :authenticate_user!
  # GET /folders
  # GET /folders.json
  def index
    @folders = current_user.folders
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
  end

  # GET /folders/new
  def new
    @folder = current_user.folders.new

    #if param, then in current folder
    if params[:folder_id]

      @current_folder = current_user.folders.find(params[:folder_id])

      @folder.parent_id = @current_folder.id
  end
end
  # GET /folders/1/edit
  def edit

    @folder = current_user.folders.find(params[:folder_id])
    # Change breadcrumbs as well
    @current_folder = @folder.parent
  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = current_user.folders.new(folder_params)
=begin
    respond_to do |format|
      if @folder.save
        format.html { redirect_to @folder, notice: 'Folder was successfully created.' }
        format.json { render :show, status: :created, location: @folder }

      else
        format.html { render :new }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
=end

    if @folder.save
      flash[:notice] = "Successfully created folder"

      if @folder.parent # if folder has a parent
        redirect_to browse_path(@folder.parent)

      else
        redirect_to root_url
      end

    else
        render :action => 'new'
    end
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update

    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to @folder, notice: 'Folder was successfully updated.' }
        format.json { render :show, status: :ok, location: @folder }
      else
        format.html { render :edit }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy

    @folder = current_user.folders.find(params[:id])
    @parent_folder = @folder.parent
    @folder.destroy # destroy contents as well

    flash[:notice] = "Successfully deleted folder and all contents"

    if @parent_folder
      redirect_to browse_path(@parent_folder)
    else
      redirect_to root_url
    end

    respond_to do |format|
      format.html { redirect_to folders_url, notice: 'Folder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = current_user.folders.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
      params.require(:folder).permit(:name, :parent_id, :user_id)
    end
end
