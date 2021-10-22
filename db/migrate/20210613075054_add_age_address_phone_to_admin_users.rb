class AddAgeAddressPhoneToAdminUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :admin_users, bulk: true do |t|
      t.integer :age
      t.text :address
      t.string :phone

      t.index :name
    end
  end
end
