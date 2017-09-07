class AddRedirectPathToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :redirect_path, :string
  end
end
