class AddZipcodeAddressIntroductionToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :zipcode, :string
    add_column :users, :address, :string
    add_column :users, :introduction, :string
  end
end
