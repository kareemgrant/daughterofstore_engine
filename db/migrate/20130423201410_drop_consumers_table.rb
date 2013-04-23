class DropConsumersTable < ActiveRecord::Migration
 def change
  drop_table :consumers
 end
end
