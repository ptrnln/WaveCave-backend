json.user do
    json.extract! @user, :id, :email, :username, :created_at, :updated_at
    json.tracks do
        @user.tracks.each do |track|
            json.partial! 'api/tracks/track', track: track
        end
    end
end