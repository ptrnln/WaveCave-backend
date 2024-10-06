json.set! @playlist_track.id do
    json.extract! @playlist_track,
        :track_id,
        :playlist_id
end

