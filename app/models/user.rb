class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :assets
  has_many :folders
  has_many :shared_folders, :dependent => :destroy
  has_many :being_shared_folders, :class_name => "SharedFolder", :foreign_key => "shared_user_id", :dependent => :destroy
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  belongs_to :invitation

  before_create :set_invitation_limit

  #validates_presence_of :invitation_id, :message => 'is required'
  #validates_uniqueness_of :invitation_id
   def invitation_token
  	invitation.token if invitation
  end

  def invitation_token=(token)
  	self.invitation = Invitation.find_by_token(token)
  end

  private

  def set_invitation_limit
  	self.invitation_limit = 5
  end


end
