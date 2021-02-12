class CreateFootprints < ActiveRecord::Migration[6.0]
  def change
    create_table :footprints do |t|
      t.integer    :visitor_user_id,   null: false
      t.integer    :visited_user_id,   null: false

      t.timestamps
    end
  end
end