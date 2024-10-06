class Api::UsersController < ApplicationController
  
  wrap_parameters include: User.attribute_names + ['password']

  def index 
    @users = User.all
    render 'index'
  end

  def create
    @user = User.new(user_params)

    if (@user.save) 
      login!(@user)
      render :show
    else
      render json: { errors: @user.errors.full_messages }, 
        status: :unprocessable_entity
    end
  end

  def show
    @user = User.find_by(username: CGI.unescape(params[:username]))
    @user ||= User.find_by(email: params[:credential])
    @user ||= User.find_by(username: params[:credential])
    
    if @user
      render 'users/show'
    else
      render json: { message: 'User not found' }, status: :not_found
    end
  end
# -------------------------------------------------------------
  private

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end
end
