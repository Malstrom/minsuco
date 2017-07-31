class AddRuiToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :rui, :string
  end
end
