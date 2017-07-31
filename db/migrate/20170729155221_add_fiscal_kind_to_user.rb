class AddFiscalKindToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :fiscal_kind, :integer
  end
end
