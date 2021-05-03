class ExerciseSerializer
  include JSONAPI::Serializer
  attributes :name, :link, :sets, :reps, :rest, :tempo
end
