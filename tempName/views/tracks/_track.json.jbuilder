json.set! track.id do
    json.extract! track,
        :id,
        :title,
        :description,
        :genre,
        :created_at,
        :updated_at
        json.photo_url track.photo.attached? ? track.photo.url : '' 
end