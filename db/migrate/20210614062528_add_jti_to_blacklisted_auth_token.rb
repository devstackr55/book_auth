class AddJtiToBlacklistedAuthToken < ActiveRecord::Migration[6.0]
  def change
    add_column :blacklisted_auth_tokens, :jti, :text
  end
end
