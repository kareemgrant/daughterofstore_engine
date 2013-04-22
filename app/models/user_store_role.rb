class UserStoreRole < ActiveRecord::Base
  attr_accessible :user_id, :store_id, :role

  belongs_to :user
  belongs_to :store

  validates_presence_of :store_id, :user_id, :role

  validates :role, presence: true,
                   inclusion: {in: %w(admin stocker)}

  def admin?
    self.role == 'admin'
  end

  def stocker?
    self.role == 'stocker'
  end
end
