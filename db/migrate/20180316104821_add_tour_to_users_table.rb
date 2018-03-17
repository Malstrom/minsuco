class AddTourToUsersTable < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :tour, :boolean, default:true
  end
end
