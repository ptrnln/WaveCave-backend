@playlists.each do |playlist|
    json.set! playlist.id do
        json.extract! playlist,
            :title,
            :description,
            :created_at,
            :updated_at
        json.publisher do
            json.partial! 'api/users/user', user: playlist.publisher
        end
        json.tracks playlist.tracks do |track|
            json.partial! 'api/tracks/track', track: track
        end
    end
end