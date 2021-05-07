class Routine < ApplicationRecord
  validates :day, presence: true

  belongs_to :user

  has_many :exercises, dependent: :destroy
end
