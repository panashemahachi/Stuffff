class Folder < ActiveRecord::Base
	belongs_to :user

	# D all once folder gone
	has_many :assets, :dependent => :destroy
	has_many :shared_folders, :dependent => :destroy
	acts_as_tree
end
