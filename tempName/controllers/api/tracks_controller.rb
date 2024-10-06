class Api::TracksController < ApplicationController
    # prepend_before_action :require_logged_in_as_owner, only: :require_logged_in
    before_action :require_logged_in_as_owner, only: [ :update, :destroy ]
    before_action :require_logged_in, only: [ :create ]

# ---------------------- Backend Routes ------------------------

    def index
        @tracks = Track.all
        if @tracks
            render :index
        else
            render nothing: true, status: :no_content
        end
    end

    def create
        @track = Track.new(track_params)
        @track.artist_id ||= current_user.id
        @track.source.attach(track_params[:source])
        @track.photo.attach(track_params[:photo])
        

        if @track.save 
            render :show
        else
            render json: { errors: @track.errors.full_messages }, 
                status: :unprocessable_entity
        end
    end

    def show
        if params[:title] && params[:username] 
            @user = User.find_by(username: CGI.unescape(params[:username])) 
            @track = Track.find_by(title: CGI.unescape(params[:title]), artist_id: @user.id)
        else
            @track = Track.find(params[:id])
        end

        if @track
            render :show
        else
            render json: { message: 'Track not found' }, 
                status: :not_found
        end
    end

    def update

        @track = Track.find(params[:id])

        @track.source.attach(track_params[:source]) if track_params[:source]
        
        
        if @track.update(track_params)
            render :show
        else
            render json: { errors: @track.errors.full_messages },
                status: :unprocessable_entity
        end
    end

    def destroy
        Track.destroy(params[:id])
        render json: { message: 'Track successfully deleted' }
    end

# -------------- Track-specific helper methods ------------------
    private

    def require_logged_in_as_owner
        @track = Track.find(params[:id])

        unless current_user && @track[:artist_id] == current_user.id
            render json: { message: 'You are not the owner of this track' }, status: :unauthorized
        end
    end


    def track_params
        params.require(:track).permit(
            :id,
            :artist_id, 
            :title, 
            :description,
            :genre, 
            :file_type, 
            :duration,
            :source,
            :photo
            )
    end
end
