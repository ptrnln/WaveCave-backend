json.track do
    json.set! @track.id do
        json.extract! @track, 
        :id, 
        :title, 
        :description, 
        :genre, 
        :file_type, 
        :duration, 
        :created_at,
        :updated_at;
        json.photo_url @track.photo.attached? ? @track.photo.url : ''
        json.source_url @track.source.url
        json.source_name @track.source.filename
        json.partial! 'api/users/artist', user: @track.artist
    end
end