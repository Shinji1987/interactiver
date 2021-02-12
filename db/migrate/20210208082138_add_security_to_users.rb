class AddSecurityToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :block_status, :integer
  end
end