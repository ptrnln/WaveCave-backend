class CreatePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :playlists do |t|
      t.references :publisher, null: false, index: true, foreign_key: { to_table: :users }
      t.string :title, null: false
      t.text :description
      t.timestamps
    end
  end
end
