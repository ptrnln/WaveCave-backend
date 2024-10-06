class Api::PlaylistsController < ApplicationController

    def index 
        @playlists = Playlist.all

        render :index
    end

    def show
        @playlist = Playlist.find(params[:id]);
        
        render :show
    end

    def create
        @playlist = Playlist.new(playlist_params)

        if @playlist.save
            render :show
        else
            render json: { errors: @playlist.errors.full_messages },
                status: :unprocessable_entity
        end
    end

    def update
        @playlist = Playlist.find(params[:id])

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
        params.require(:playlist).permit(:publisher_id, :title, :description)
    end

end
