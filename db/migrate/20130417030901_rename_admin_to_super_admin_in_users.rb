class RenameAdminToSuperAdminInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :admin, :super_admin
  end
end
