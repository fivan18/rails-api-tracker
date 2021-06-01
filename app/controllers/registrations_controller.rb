class RegistrationsController < ApplicationController
  def create
    user = User.new(registration_params)
    user.save!
    render json: UserSerializer.new(user), status: :created
  rescue ActiveRecord::RecordInvalid
    render json: { errors: user.errors }, status: :unprocessable_entity
  end

  private

  def registration_params
    params
      .require(:data)
      .require(:attributes)
      .permit(:username, :password) ||
      ApplicationController::Parameters.new
  end
end
