class Exercise < ApplicationRecord
  validates :name, presence: true
  validates :sets, presence: true
  validates :reps, presence: true
  validates :rest, presence: true
  validates :tempo, presence: true

  belongs_to :routine
end
