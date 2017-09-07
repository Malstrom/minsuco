class AddAddressAndCompanyFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :state, :string
    add_column :users, :city, :string
    add_column :users, :address, :string
    add_column :users, :address_num, :string
    add_column :users, :zip, :string

    remove_column :users, :location
  end
end
