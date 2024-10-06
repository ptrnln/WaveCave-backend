class CreatePlaylistTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :playlist_tracks do |t|
      t.references :track, null: false
      t.references :playlist, null: false
      t.timestamps
    end
  end
end
