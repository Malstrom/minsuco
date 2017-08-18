class AddStatusToAttendees < ActiveRecord::Migration[5.1]
  def change
    add_column :attendees, :status, :integer
  end
end
