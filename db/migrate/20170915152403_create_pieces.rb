class CreatePieces < ActiveRecord::Migration[5.1]
  def change
    create_table :pieces do |t|
      t.belongs_to :attendee, foreign_key: true, index:true
      t.string :name
      t.integer :value
      t.integer :duration

      t.timestamps
    end
  end
end
