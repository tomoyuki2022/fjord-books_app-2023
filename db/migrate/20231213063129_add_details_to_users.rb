class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :postal_code, :string
    add_column :users, :address, :text
    add_column :users, :introduction, :text
  end
end
