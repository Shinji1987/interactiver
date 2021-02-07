class AddShopAddressToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :shop_address, :string
  end
end
