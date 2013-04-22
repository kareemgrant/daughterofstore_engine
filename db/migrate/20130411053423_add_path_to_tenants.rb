class AddPathToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :path, :string
    remove_column :tenants, :subdomain
  end
end
