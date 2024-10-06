json.users do
    @users.each do |user|
        json.set! user.id do
            json.extract! user,
                :id, 
                :email, 
                :username,
                :playlists,
                :created_at, 
                :updated_at
            json.tracks do 
                user.tracks.each do |track|
                    json.partial! 'api/tracks/track', track: track
                end
            end
        end
    end
end