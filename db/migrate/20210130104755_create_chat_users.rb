class CreateChatUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_users do |t|
      t.integer    :created_user_id,          :null => false
      t.integer    :invited_user_id,          :null => false
      t.references :chat,                     :null => false, :foreign_key => true

      t.timestamps
    end
  end
end
