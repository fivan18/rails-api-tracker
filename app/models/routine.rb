class Routine < ApplicationRecord
  validates :day, presence: true, uniqueness: true

  belongs_to :user

  has_many :exercises, dependent: :destroy
end
