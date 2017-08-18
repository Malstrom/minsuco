class CreateChannelSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :channel_subscriptions do |t|
      t.references :user, foreign_key: true
      t.references :channel, foreign_key: true
      t.boolean :muted

      t.timestamps
    end
  end
end
