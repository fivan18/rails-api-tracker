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

    it 'has a not unique day' do
      routine = create :routine, user: user
      expect(routine).to be_valid
      routine_repeated_day = build :routine, user: user, day: routine.day
      expect(routine_repeated_day).not_to be_valid
      expect(routine_repeated_day.errors[:day]).to include('has already been taken')
    end
  end
end
