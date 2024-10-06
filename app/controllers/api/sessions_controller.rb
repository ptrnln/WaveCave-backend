class Api::SessionsController < ApplicationController
    
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
        @user = User.find_by_credentials(params[:credential], params[:password])

        errors = { credential: [], password: [], overall: [] }

        if (params[:credential].length == 0)
            if (params[:password].length == 0)
                errors[:password].push("Password field cannot be blank.")
            end
            errors[:credential].push("Username/email field cannot be blank.")

            render json: { errors: errors }, status: :unauthorized
        elsif @user
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
end
