class PlaylistsController < ApplicationController

    def index 
        @playlists = Playlist.includes(:tracks).all

        render :index
    end

    def show
        @playlist = Playlist.includes(:tracks).find(params[:id]);
        
        render :show
    end

    def create
        @playlist = Playlist.new(playlist_params.except(:photo))
        @playlist.photo.attach(playlist_params[:photo])

        if @playlist.save
            render :show
        else
            render json: { errors: @playlist.errors.full_messages },
                status: :unprocessable_entity
        end
    end

    def update
        @playlist = Playlist.includes(:tracks).find(params[:id])

        if @playlist.update(playlist_params)
            render :show
        else
            render json: { errors: @playlist.errors.full_messages },
                status: :unprocessable_entity
        end
    end

    def destroy
        Playlist.destroy(params[:id])
    end

    private

    def playlist_params
        params.require(:playlist).permit(:publisher_id, :title, :description, :photo)
    end

end
