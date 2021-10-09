class ExerciseSerializer < ActiveModel::Serializer
  attributes :id, :name, :link, :sets, :reps, :rest, :tempo

  belongs_to :routine, serializer: RoutineSerializer
end
