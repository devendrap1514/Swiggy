class AddGoogleAuthToUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :avatar_url
    end
  end
end
