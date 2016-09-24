class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :team_name
      t.string :tags, array: true
      t.text :description
      t.hstore :prize
      t.references :event, foreign_key: true

      t.timestamps
    end
    add_index :projects, :tags, using: 'gin'
  end
end
