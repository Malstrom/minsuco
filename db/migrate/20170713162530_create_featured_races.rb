class CreateFeaturedRaces < ActiveRecord::Migration[5.1]
  def change
    create_table :featured_races do |t|
      t.references :race, foreign_key: true
      t.datetime :starts_at
      t.datetime :ends_at
      t.timestamps
    end
  end
end
