class CreateFriendRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :friend_requests do |t|
      t.integer   :from_user_id,           null: false
      t.integer   :to_user_id,             null: false
      t.integer   :requesting_status,      null: false

      t.timestamps
    end
  end
end
