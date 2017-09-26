class AttendeesBelongsToCategories < ActiveRecord::Migration[5.1]
  def change
    add_reference :attendees, :category, index: true
  end
end
