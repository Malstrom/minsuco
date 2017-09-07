class AddThemeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :theme, :string, default: 'theme-g'
  end
end