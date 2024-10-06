@playlists.each do |playlist|
    json.set! playlist.id do
        json.extract! playlist,
            :title,
            :description,
            :publisher,
            :created_at,
            :updated_at
    end
end