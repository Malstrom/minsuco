class CreateCommissions < ActiveRecord::Migration[5.1]
  def change
    create_table :commissions do |t|
      t.belongs_to :race, foreign_key: true, index: true
      t.decimal :value, precision:10, scale:2
      t.integer :duration

      t.timestamps
    end
  end
end
