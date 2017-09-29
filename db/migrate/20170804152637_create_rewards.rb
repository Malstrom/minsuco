class CreateRewards < ActiveRecord::Migration[5.1]
  def change
    create_table :rewards do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.integer :open_races
      t.integer :join_private

      t.timestamps
    end
  end
end
