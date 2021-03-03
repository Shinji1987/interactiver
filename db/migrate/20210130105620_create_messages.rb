class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text       :content,               :null => false
      t.integer    :sent_user_id,          :null => false
      t.integer    :received_user_id,      :null => false
      t.references :chat,                  :null => false, :foreign_key => true

      t.timestamps
    end
  end
end
