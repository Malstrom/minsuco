class AddIntentToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :intent, :integer
  end
end
