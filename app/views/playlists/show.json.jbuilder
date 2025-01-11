json.set! @playlist.id do
    json.extract! @playlist,
        :id,
        :title,
        :description,
        :created_at,
        :updated_at

    json.publisher do
        json.partial! 'api/users/user', user: @playlist.publisher
    end

    json.tracks do
        @playlist.tracks.each do |track|
            json.set! track.id do
                json.partial! 'api/tracks/track', track: track
            end
        end
    end

    json.photo_url @playlist.photo.attached? ? @playlist.photo.url : nil
end