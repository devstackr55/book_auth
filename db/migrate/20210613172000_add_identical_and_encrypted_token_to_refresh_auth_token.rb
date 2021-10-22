class AddIdenticalAndEncryptedTokenToRefreshAuthToken < ActiveRecord::Migration[6.0]
  def change
    change_table :refresh_auth_tokens do |t|
      t.text :encrypted_token

      t.references :identical, polymorphic: true
    end
  end
end
