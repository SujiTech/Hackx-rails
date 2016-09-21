class CreateAuthorizations < ActiveRecord::Migration[5.0]
  def change
    create_table :authorizations do |t|
      t.string :provider,               null: false
      t.string :uid,       limit: 1000, null: false
      t.references :user,  foreign_key: true

      t.timestamps

      t.index ["provider", "uid"], name: "index_authorizations_on_provider_and_uid", using: :btree
    end
  end
end
