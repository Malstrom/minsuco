class AddJoinValueToAttendees < ActiveRecord::Migration[5.1]
  def change
    add_column :attendees, :join_value, :integer
  end
end
