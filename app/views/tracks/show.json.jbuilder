json.tracks do
    json.key_format! ->(key) {key}
    @tracks.each do |track|
        json.set! track.puid do
            json.key_format! camelize: :lower
            json.extract! track,
            :puid,
            :title, 
            :description, 
            :genre, 
            :file_type, 
            :duration, 
            :created_at,
            :updated_at;
            json.photo_url track.photo.attached? ? track.photo.url : nil
            json.source_url track.source.url
            json.source_name track.source.filename 
            json.artist do
                json.partial! 'api/users/user', user: track.artist
            end
        end
    end 
end