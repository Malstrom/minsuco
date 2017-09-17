class CreateCommissions < ActiveRecord::Migration[5.1]
  def change
    create_table :commissions do |t|
      t.belongs_to :race, foreign_key: true, index: true
      t.integer :value
      t.integer :starts
      t.integer :ends

      t.timestamps
    end
  end
end
