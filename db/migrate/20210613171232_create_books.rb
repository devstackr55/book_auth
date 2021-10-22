class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.integer :price, null: false

      t.references :admin_user, null: false
      t.timestamps
    end
  end
end
