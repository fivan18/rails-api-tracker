class AccessTokensController < ApplicationController
  before_action :authorize!, except: :create

  def create
    authenticator = UserAuthenticator.new(authentication_params)
    authenticator.perform

    render json: AccessTokenSerializer.new(authenticator.access_token), status: :created
  end

  def destroy
    current_user.access_token.destroy
  end

  private

  def authentication_params
    params.dig(:data, :attributes)&.permit(:username, :password).to_h.symbolize_keys
  end
end
