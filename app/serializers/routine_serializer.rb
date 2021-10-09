class RoutineSerializer < ActiveModel::Serializer
  attributes :id, :day

  has_many :exercises, serializer: ExerciseSerializer
end
