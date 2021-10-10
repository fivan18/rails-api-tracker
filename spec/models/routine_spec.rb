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

    it 'should validate uniqueness of day' do
      routine = create :routine, user: user, day: '2021-8-21'
      other_routine = build :routine, user: user, day: routine.day
      expect(other_routine).not_to be_valid
      other_routine.day = '2021-8-20'
      expect(other_routine).to be_valid
    end
  end
end
