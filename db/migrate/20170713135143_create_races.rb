class CreateRaces < ActiveRecord::Migration[5.1]
  def change
    create_table :races do |t|
      t.belongs_to :users, index: true, foreign_key: true
      t.string :name
      t.string :category
      t.string :recipients
      t.decimal :race_value
      t.decimal :compensation_amount
      t.integer :compensation_kind
      t.integer :pieces_amount
      t.decimal :compensation_start_amount
      t.integer :max_attendees
      t.timestamps
    end
  end
end
