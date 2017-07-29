class CreateRaces < ActiveRecord::Migration[5.1]
  def change
    create_table :races do |t|
      t.belongs_to :owner, foreign_key: { to_table: :users }, index: true
      t.string :name
      t.text :description
      t.belongs_to :category
      t.string :recipients
      t.decimal :race_value, :precision => 8, :scale => 2
      t.decimal :compensation_amount
      t.integer :pieces_amount
      t.decimal :compensation_start_amount, :precision => 8, :scale => 2
      t.integer :max_attendees
      t.integer :kind
      t.integer :status
      t.string  :permalink
      t.integer :price
      t.string  :redirect_path, :default => "/races"
      t.datetime :starts_at
      t.datetime :ends_at
      t.timestamps
    end
  end
end
