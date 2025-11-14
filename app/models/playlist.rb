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
    has_one_attached :photo

    accepts_nested_attributes_for :tracks, reject_if: ->(attributes){ attributes['title'].blank? }, allow_destroy: true
end
