class ExercisesController < ApplicationController
  before_action :authorize!
  before_action :routine
  before_action :set_exercise, only: %i[show update destroy]

  def index
    @exercises = @routine.exercises.all

    render json: serializer.new(@exercises), status: :ok
  end

  def show
    render json: serializer.new(@exercise), status: :ok
  end

  def create
    @exercise = @routine.exercises.build(exercise_params)
    @exercise.save!

    render json: serializer.new(@exercise), status: :created
  rescue ActiveRecord::RecordInvalid
    render json: { errors: @exercise.errors }, status: :unprocessable_entity
  end

  def update
    @exercise.update!(exercise_params)

    render json: serializer.new(@exercise), status: :ok
  rescue ActiveRecord::RecordInvalid
    render json: { errors: @exercise.errors }, status: :unprocessable_entity
  end

  def destroy
    @exercise.destroy
  end

  def progress
    @exercise = Exercise.joins(:routine).where("routines.user_id = #{@current_user.id}
      AND exercises.name = '#{params[:name]}'").order('routines.day ASC')

    render json: serializer.new(@exercises), status: :ok
  end

  private

  def set_exercise
    @exercise = @routine.exercises.find(params[:id])
  end

  def exercise_params
    params
      .require(:exercise)
      .permit(:name, :link, :sets, :reps, :rest, :tempo) || ApplicationController::Parameters.new
  end

  def serializer
    ExerciseSerializer
  end

  def routine
    @routine = @current_user.routines.find(params[:routine_id])
  end
end
