class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :request_status, :integer
  end
end
