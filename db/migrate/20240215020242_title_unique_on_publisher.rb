class TitleUniqueOnPublisher < ActiveRecord::Migration[7.0]
  def change
    add_index :playlists, [:publisher_id, :title], unique: true
  end
end
