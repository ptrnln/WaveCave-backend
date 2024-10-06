# == Schema Information
#
# Table name: playlist_tracks
#
#  id          :bigint           not null, primary key
#  track_id    :bigint           not null
#  playlist_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class PlaylistTrack < ApplicationRecord
    validates :playlist_id, :track_id, presence: true

    belongs_to :playlist
    belongs_to :track
end
