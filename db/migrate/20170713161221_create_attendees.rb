class CreateAttendees < ActiveRecord::Migration[5.1]
  def change
    create_table :attendees do |t|
      t.belongs_to :user, index: true
      t.belongs_to :race, index: true
      t.timestamps
    end
  end
end
