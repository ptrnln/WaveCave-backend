# == Schema Information
#
# Table name: tracks
#
#  id          :bigint           not null, primary key
#  artist_id   :bigint           not null
#  title       :string           not null
#  description :text
#  file_type   :string           not null
#  duration    :float            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  genre       :string
#
class Track < ApplicationRecord

    validates :artist_id, :duration, presence: true
    validates :title, presence: true, length: { minimum: 1, maximum: 40 }
    validates :file_type, inclusion: { in: %w(wav mpeg flac) }

    belongs_to :artist, class_name: "User", foreign_key: "artist_id"
    has_many :playlist_tracks
    has_many :playlists, through: :playlist_tracks

    has_one_attached :photo
    has_one_attached :source

    validate :source_presence
    validate :name_unique_on_artist, on: :create

    private

    def source_presence
        return true if self.source.attached?
        self.errors.add(:source_file, "must be attached");
        return false
    end

    def name_unique_on_artist
        return true if self.artist&.tracks&.none?{ |track| track.title == self.title }
        self.errors.add(:title, ": '#{self.title}' cannot be used more than once by the same artist")
        return false
    end
end
