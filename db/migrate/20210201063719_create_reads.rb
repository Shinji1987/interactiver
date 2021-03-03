class CreateReads < ActiveRecord::Migration[6.0]
  def change
    create_table :reads do |t|
      t.integer    :received_user_id,   :null => false
      t.references :message,            :null => false, :foreign_key => true
      t.boolean    :complete,           :null => false

      t.timestamps
    end
  end
end