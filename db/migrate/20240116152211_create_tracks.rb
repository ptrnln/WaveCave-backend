class CreateTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :tracks do |t|
      t.references :artist, null: false, index: true, foreign_key: { to_table: :users }
      t.string :title, null: false
      t.text :description
      t.string :source_url, null: false, index: { unique: true }
      t.string :image_url
      t.string :file_type, null: false
      t.integer :duration, null: false
      t.timestamps
    end
  end
end
