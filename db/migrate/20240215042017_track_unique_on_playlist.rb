class TrackUniqueOnPlaylist < ActiveRecord::Migration[7.0]
  def change
    add_index :playlist_tracks, [:playlist_id, :track_id], unique: true
  end
end
