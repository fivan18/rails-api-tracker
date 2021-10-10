class ExerciseSerializer < ActiveModel::Serializer
  attributes :id, :name, :link, :sets, :reps, :rest, :tempo
end
