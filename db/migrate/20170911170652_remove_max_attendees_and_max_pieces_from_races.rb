class RemoveMaxAttendeesAndMaxPiecesFromRaces < ActiveRecord::Migration[5.1]
  def change
    remove_column :races, :max_attendees
    remove_column :races, :min_pieces
  end
end
