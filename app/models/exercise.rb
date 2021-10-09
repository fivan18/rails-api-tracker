class Exercise < ApplicationRecord
  validates :name, presence: true, allow_blank: false
  validates :sets, presence: true, allow_blank: false
  validates :reps, presence: true, allow_blank: false
  validates :rest, presence: true, allow_blank: false
  validates :tempo, presence: true, allow_blank: false

  belongs_to :routine
end
