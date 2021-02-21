class RemoveShopAddressFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :shop_address, :string
  end
end
