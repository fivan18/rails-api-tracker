class ExercisesController < ApplicationController
  before_action :set_exercise, only: %i[show update destroy]
  before_action :authorize!

  def index
    @exercises = routine.exercises.all

    render json: serializer.new(@exercises)
  end

  def show
    render json: serializer.new(@exercise)
  end

  def create
    @exercise = routine.exercises.build(exercise_params)

    if @exercise.save
      render json: serializer.new(@exercise), status: :created
    else
      render json: @exercise.errors, status: :unprocessable_entity
    end
  end

  def update
    if @exercise.update(exercise_params)
      render json: serializer.new(@exercise)
    else
      render json: @exercise.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @exercise.destroy
  end

  def progress
    @exercises = Exercise.joins(
      "INNER JOIN routines
        ON routines.id = exercises.routine_id
        AND routines.user_id = #{current_user.id}
        AND exercises.name = '#{params[:name]}'"
    )

    render json: serializer.new(@exercises)
  end

  private

  def set_exercise
    @exercise = routine.exercises.find(params[:id])
  end

  def exercise_params
    params
      .require(:data)
      .require(:attributes)
      .permit(:name, :link, :sets, :reps, :rest, :tempo) || ApplicationController::Parameters.new
  end

  def serializer
    ExerciseSerializer
  end

  def routine
    current_user.routines.find(params[:routine_id])
  end
end
