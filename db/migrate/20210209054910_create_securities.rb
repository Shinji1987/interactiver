class CreateSecurities < ActiveRecord::Migration[6.0]
  def change
    create_table :securities do |t|
      t.integer    :block_user_id,   :null => false
      t.integer    :blocked_user_id,   :null => false      

      t.timestamps
    end
  end
end