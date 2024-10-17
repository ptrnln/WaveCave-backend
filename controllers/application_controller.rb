class ApplicationController < ActionController::API

    include ActionController::RequestForgeryProtection

    puts "test"

    if Rails.env.development?
        logger.debug "test"
        puts "test"
        rescue_from ActionController::InvalidAuthenticityToken,
            with: :invalid_authenticity_token
        protect_from_forgery with: :exception
        before_action :attach_authenticity_token
    end

    rescue_from StandardError, with: :unhandled_error
    # rescue_from ActionController::InvalidAuthenticityToken,
    #    with: :invalid_authenticity_token
    
    # protect_from_forgery with: :exception
    before_action :snake_case_params
    # before_action :attach_authenticity_token

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def login!(user)
        session[:session_token] = user.reset_session_token!
    end

    def logout!
        current_user&.reset_session_token!
        session[:session_token] = nil
        @current_user = nil
        !@current_user
    end

    def require_logged_in
        unless current_user
            render json: { message: 'Unauthorized' }, status: :unauthorized
        end
    end

#-------------------------------------------------------------------------------

    private

    def snake_case_params
        params.deep_transform_keys!(&:underscore)
    end

    def attach_authenticity_token
        headers['X-CSRF-Token'] = masked_authenticity_token(session)
        # logger.debug "Attaching CSRF token to response: #{headers['X-CSRF-Token']}"
        # logger.debug "Response headers: #{headers.keys.join(", ")}"
    end

    def invalid_authenticity_token
        # logger.debug "Invalid X-CSRF-Token: #{request.headers['X-CSRF-Token']}"
        render json: { message: 'Invalid authenticity token' }, 
          status: :unprocessable_entity
    end
      
    def unhandled_error(error)
        if request.accepts.first.html?
            raise error
        else
            @message = "#{error.class} - #{error.message}"
            @stack = Rails::BacktraceCleaner.new.clean(error.backtrace)
            render 'errors/internal_server_error', status: :internal_server_error
        
            logger.error "\n#{@message}:\n\t#{@stack.join("\n\t")}\n"
        end
    end
end
