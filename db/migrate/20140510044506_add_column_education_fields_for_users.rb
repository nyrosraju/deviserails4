class AddColumnEducationFieldsForUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :hometown, :string
    add_column :users, :highschool, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :college, :string
    add_column :users, :occupation, :string
    add_column :users, :address, :string
    add_column :users, :postalcode, :string
    
  end
end
