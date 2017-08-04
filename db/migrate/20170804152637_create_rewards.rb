class CreateRewards < ActiveRecord::Migration[5.1]
  def change
    create_table :rewards do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.integer :public_races, :default => 0
      t.integer :join_private, :default => 0

      t.timestamps
    end
  end
end
