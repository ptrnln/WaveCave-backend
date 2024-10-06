class Api::PlaylistTracksController < ApplicationController
    def index
        @playlist_tracks = PlaylistTrack.all

        render :index
    end

    def show
        id = params[:id]
        @playlist_track = Playlist.find(id)

        if @playlist_track
            render :show
        else
            render json: { errors: ["No playlist-track association by id: #{id}"] },
                status: :not_found
        end
    end

    def create
        @playlist_track = PlaylistTrack.new(playlist_track_params);

        if @playlist_track.save
            render :show
        else
            render json: { errors: @playlist_track.errors.full_messages },
                status: :unprocessable_entity
        end
    end

    def destroy
        id = params[:id]
        @playlist_track = PlaylistTrack.find(id)

        if @playlist_track
            @playlist_track.destroy
            render json: { message: "Playlist-track association successfully destroyed"}
        else
            render json: { errors: ["No playlist-track association by id: #{id}"]}
        end
    end


    private

    def playlist_track_params
        params.require(:playlist_track).permit(:track_id, :playlist_id)
    end
end
