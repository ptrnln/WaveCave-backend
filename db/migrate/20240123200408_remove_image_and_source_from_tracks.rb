class RemoveImageAndSourceFromTracks < ActiveRecord::Migration[7.0]
  def change
    remove_column :tracks, :source_url, :image_url
  end
end
