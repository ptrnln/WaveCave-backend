class SessionsController < ApplicationController

    # before_action :set_headers
    # wrap_parameters include: ['credential', 'password']

    def show
        if current_user
            @user = current_user
            render 'users/show'
        else
            render json: { errors: {
                user: ['No user currently logged in']
            }}
        end
    end

    def create
        if (session_params[:credential]&.length == 0)
            if (session_params[:password].length == 0)
                errors[:password].push("Password field cannot be blank.")
            end
            errors[:credential].push("Username/email field cannot be blank.")

            render json: { errors: errors }, status: :unauthorized
        end

        @user = User.find_by_credentials(session_params[:credential], session_params[:password])
        
        errors = { credential: [], password: [], overall: [] }

        if @user
            login!(@user)
            render 'users/show'
        else
            errors[:overall].push("Invalid credentials/password");
            render json: { errors: errors }, status: :unauthorized
        end
    end

    def destroy
        if current_user && logout! 
            render json: { message: 'success' } 
        end
    end

    private

    def session_params
        params.permit(:credential, :password)
    end

    # def set_headers
    #     logger.debug "Setting origin header"
    #     headers['Access-Control-Allow-Origin'] = "https://ph4se.dev"
    # end
end
