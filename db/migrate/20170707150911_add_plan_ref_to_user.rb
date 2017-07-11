class AddPlanRefToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :plan, index: true, foreign_key: true
  end
end
