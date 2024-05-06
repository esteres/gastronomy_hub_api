class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token

  class AuthenticationError < StandardError
	  def initialize(message = 'Invalid token. Please log in again.')
	    super(message)
	  end
	end
	
	class AuthorizationError < StandardError
	  def initialize(message = 'You are not authorized to perform this action.')
	    super(message)
	  end
	end

  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from AuthenticationError, with: :handle_unauthenticated
  rescue_from AuthorizationError, with: :handle_unauthorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  private

  def authenticate_user
    token, _options = token_and_options(request)
    user_id = AuthenticationTokenService.decode(token)
    user = User.find_by('id = ?', user_id)

    raise AuthenticationError, 'User not found for token' if user.nil?
  rescue JWT::ExpiredSignature
	  raise AuthenticationError, 'Your token has expired. Please log in again.'
  rescue JWT::DecodeError
    raise AuthenticationError
  end

  def parameter_missing(error)
    render json: {
      error: "param is missing or the value is empty: #{error.param}"
    }, status: :unprocessable_entity
  end
  
  def handle_unauthenticated(error)
    render json: {
      error: error.message
    }, status: :unauthorized
  end

  def handle_unauthorized(error)
    render json: {
      error: error.message
    }, status: :forbidden
  end

  def not_found(error)
    render json: { error: 'User not found' }, status: :not_found
  end
end
