class RoutinesController < ApplicationController
  before_action :authorize!
  before_action :set_routine, only: %i[show update destroy]

  def index
    @routines = @current_user.routines.all

    render json: serializer.new(@routines), status: :ok
  end

  def show
    render json: serializer.new(@routine), status: :ok
  end

  def create
    @routine = @current_user.routines.build(routine_params)
    @routine.save!

    render json: serializer.new(@routine), status: :created
  rescue ActiveRecord::RecordInvalid
    render json: { errors: @routine.errors }, status: :unprocessable_entity
  end

  def update
    @routine.update!(routine_params)
    
    render json: serializer.new(@routine), status: :ok
  rescue ActiveRecord::RecordInvalid
    render json: { errors: @routine.errors }, status: :unprocessable_entity
  end

  def destroy
    @routine.destroy
  end

  private

  def set_routine
    @routine = @current_user.routines.find(params[:id])
  end

  def routine_params
    params
      .require(:routine)
      .permit(:day) || ApplicationController::Parameters.new
  end

  def serializer
    RoutineSerializer
  end
end
