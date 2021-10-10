class ApplicationController < ActionController::API
  class AuthorizationError < StandardError; end

  rescue_from AuthorizationError, with: :authorization_error
  rescue_from User::Authenticator::AuthenticationError, with: :authentication_error
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def authorize!
    raise AuthorizationError unless current_user
  end

  def access_token
    provided_token = request.authorization&.gsub(/\ABearer\s/, '')
    @access_token = AccessToken.find_by(token: provided_token)
  end

  def current_user
    @current_user = access_token&.user
  end

  def authorization_error
    error = {
      status: '403',
      source: { pointer: '/headers/authorization' },
      title: 'Not authorized',
      detail: 'You have no right to access this resource.'
    }
    render json: { errors: [error] }, status: 403
  end

  def authentication_error
    error = {
      status: '401',
      source: { pointer: '/user/params' },
      title: 'Invalid login or password',
      detail: 'You must provide valid credentials in order to exchange them for token.'
    }
    render json: { errors: [error] }, status: 401
  end

  def not_found
    error = {
      status: '404',
      source: { pointer: '/' },
      title: 'Resource not found',
      detail: 'You must provide a valid resource id.'
    }
    render json: { errors: [error] }, status: 404
  end
end
