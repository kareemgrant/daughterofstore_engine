class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :display_name,
                  :email,
                  :full_name,
                  :password,
                  :password_confirmation,
                  :store_id,
                  :store_name

  attr_accessor :store_name

  validates_uniqueness_of :email
  validates_presence_of :full_name, :email, :password
  validates :display_name, :length => { :minimum => 2,
    :maximum => 32 }, :allow_blank => true

  has_many :user_store_roles
  has_many :stores, :through => :user_store_roles
  has_many :bids


  def assign_super_admin
    self.super_admin = true
    self.save
  end

  def is_super_admin?
    self.super_admin
  end

  def assign_role(store_id, role)
    UserStoreRole.find_or_initialize_by_user_id_and_store_id(user_id: self.id, store_id: store_id).update_attributes(role: role)
  end

end
