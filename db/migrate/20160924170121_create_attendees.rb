class CreateAttendees < ActiveRecord::Migration[5.0]
  def change
    create_table :attendees do |t|
      t.string :name
      t.integer :gender
      t.integer :education
      t.boolean :graduation
      t.date :birthday
      t.string :school_name
      t.string :email
      t.string :phone_number
      t.string :github
      t.references :project, foreign_key: true

      t.timestamps
    end
    add_index :attendees, :email, unique: true
  end
end
