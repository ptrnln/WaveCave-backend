class RemoveImageUrlFromTracks < ActiveRecord::Migration[7.0]
  def change
    remove_column :tracks, :image_url
  end
end
