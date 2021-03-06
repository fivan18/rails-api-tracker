class RegistrationsController < ApplicationController
  def create
    user = User.new(registration_params)
    user.save!
    render json: user, status: :created
  rescue ActiveRecord::RecordInvalid
    render json: { errors: user.errors }, status: :unprocessable_entity
  end

  private

  def registration_params
    params
      .require(:user)
      .permit(:username, :password) ||
      ApplicationController::Parameters.new
  end
end
