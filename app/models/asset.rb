class Asset < ActiveRecord::Base

	belongs_to :user
	belongs_to :folder
	
	has_attached_file :uploaded_file,  
              :path => "assets/:id/:basename.:extension", 
              :storage => :s3, 
              :s3_credentials => "#{Rails.root}/config/amazon_s3.yml", 
              :bucket => "mystuffapp"
  
	validates_attachment :uploaded_file, :content_type => {:content_type => %w(image/jpeg image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}

	def file_name 
    	uploaded_file_file_name 
	end

	def file_size 
    	uploaded_file_file_size 
	end

	def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
   # where("uploaded_file like ? OR title like ?", "%#{query}%", "%#{query}%")
   where("uploaded_file_file_name like ?", "%#{query}%")
  end

end
