json.set! @playlist.id do
    json.extract! @playlist,
        :title,
        :description,
        :publisher,
        :created_at,
        :updated_at

    json.tracks @playlist.tracks.each do |track|
        json.partial! 'api/tracks/track', track: track
    end
end