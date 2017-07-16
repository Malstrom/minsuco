class CreateRaces < ActiveRecord::Migration[5.1]
  def change
    create_table :races do |t|
      t.belongs_to :owner, foreign_key: { to_table: :users }, index: true
      t.string :name
      t.text :description
      t.belongs_to :category
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
