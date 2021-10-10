class Routine < ApplicationRecord
  validates :day, presence: true, uniqueness: { scope: :user_id }

  belongs_to :user

  has_many :exercises, dependent: :destroy
end
