class RoutinesController < ApplicationController
  before_action :set_routine, only: %i[show update destroy]
  before_action :authorize!

  def index
    @routines = current_user.routines.all

    render json: serializer.new(@routines)
  end

  def show
    render json: serializer.new(@routine)
  end

  def create
    @routine = current_user.routines.build(routine_params)

    if @routine.save
      render json: serializer.new(@routine), status: :created, location: @routine
    else
      render json: @routine.errors, status: :unprocessable_entity
    end
  end

  def update
    if @routine.update(routine_params)
      render json: serializer.new(@routine)
    else
      render json: @routine.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @routine.destroy
  end

  private

  def set_routine
    @routine = current_user.routines.find(params[:id])
  end

  def routine_params
    params
      .require(:data)
      .require(:attributes)
      .permit(:day) || ApplicationController::Parameters.new
  end

  def serializer
    RoutineSerializer
  end
end
