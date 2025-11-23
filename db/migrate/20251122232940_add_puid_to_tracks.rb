class AddPuidToTracks < ActiveRecord::Migration[7.0]
  def change
    add_column :tracks, :puid, :string, unique: true
  end
end
