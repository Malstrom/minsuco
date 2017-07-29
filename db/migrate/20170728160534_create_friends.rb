class CreateFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :friends do |t|
      t.belongs_to :user, foreign_key: true
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
