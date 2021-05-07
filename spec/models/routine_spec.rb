require 'rails_helper'

RSpec.describe Routine, type: :model do
  describe 'validations' do
    let(:user) { create :user }

    it 'has a valid factory' do
      routine = build :routine, user: user
      expect(routine).to be_valid
      routine.save!
      another_routine = build :routine, user: user
      expect(another_routine).to be_valid
    end

    it 'has an invalid day' do
      routine = build :routine, user: user, day: ''
      expect(routine).not_to be_valid
      expect(routine.errors[:day]).to include("can't be blank")
    end
  end
end
