class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string     :shop_name
      t.integer    :shop_category_id
      t.text       :shop_description
      t.string     :shop_address
      t.references :user, :foreign_key => true

      t.timestamps
    end
  end
end
