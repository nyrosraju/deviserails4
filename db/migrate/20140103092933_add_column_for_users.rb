class AddColumnForUsers < ActiveRecord::Migration
  def change
    add_column :users, :location, :string
    add_column :users, :image, :string
    add_column :users, :username, :string
  end
end
