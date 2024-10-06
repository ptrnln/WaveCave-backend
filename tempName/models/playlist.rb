# == Schema Information
#
# Table name: playlists
#
#  id           :bigint           not null, primary key
#  publisher_id :bigint           not null
#  title        :string           not null
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Playlist < ApplicationRecord
    validates :publisher_id, :title, presence: true

    belongs_to :publisher, class_name: "User", foreign_key: "publisher_id"

    has_many :playlist_tracks
    has_many :tracks, through: :playlist_tracks
end
