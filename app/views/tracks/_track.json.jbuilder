json.key_format! ->(key) {key}
json.set! track.puid do
    json.key_format! camelize: :lower
    json.extract! track,
        :puid,
        :title,
        :description,
        :genre,
        :created_at,
        :updated_at
        json.photo_url track.photo.attached? ? track.photo.url : nil
        #Ex:- :null => false
end