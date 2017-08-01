class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :thing_type
      t.integer :thing_id
      t.belongs_to :owner,     foreign_key: { to_table: :users }, index: true
      t.belongs_to :recipient, foreign_key: { to_table: :users }, index: true
      t.string :message
      t.boolean :notifiable
      t.boolean :read

      t.timestamps
    end
  end
end
