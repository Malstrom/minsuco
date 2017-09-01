class ChangeRepientsToRaces < ActiveRecord::Migration[5.1]
  def change
    change_column :races, :recipients, :integer
  end
end
