class AddFiscalCodeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :fiscal_code, :string
  end
end
