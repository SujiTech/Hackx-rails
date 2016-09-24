class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.date :begin_at
      t.date :end_at
      t.datetime :enroll_beigin_at
      t.datetime :enroll_end_at
      t.float :latitude
      t.float :longitude
      t.string :city
      t.text :description
      t.string :cover
      t.string :logo
      t.references :organization, foreign_key: true

      t.timestamps
    end
  end
end
