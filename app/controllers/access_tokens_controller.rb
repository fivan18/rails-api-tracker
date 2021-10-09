class AccessTokensController < ApplicationController
  before_action :authorize!, except: :create

  def create
    authenticator = User::Authenticator.new(authentication_params.to_h.symbolize_keys)
    authenticator.perform

    render json: authenticator.access_token, status: :created
  end

  def destroy
    current_user.access_token.destroy
  end

  private

  def authentication_params
    params
      .require(:user)
      .permit(:username, :password) ||
      ApplicationController::Parameters.new
  end
end
