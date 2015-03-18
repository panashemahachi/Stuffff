class InfoController < ApplicationController

	def home
	end

	def main
		# show root folders
       	 @folders = current_user.folders.roots


	if params[:search]
      @assets = Asset.where(:user_id => current_user.id).search(params[:search]).order("created_at DESC")

  else
      # show root files w/ no folder id
      @assets = current_user.assets.where("folder_id is NULL").order("uploaded_file_file_name desc")
  end
	end

	def browse

		@current_folder = current_user.folders.find(params[:folder_id])

		if @current_folder

			# Get folders inside current
			@folders = @current_folder.children

			# Show files in folder
			@assets = @current_folder.assets.order("uploaded_file_file_name desc")

			render :action => "main"

		else

			flash[:error] = "This isn't yours!"
			redirect_to root_url

		end
	end
end
