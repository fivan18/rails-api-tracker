require 'rails_helper'

RSpec.describe Exercise, type: :model do
  describe 'validations' do
    let(:user) { create :user }
    let(:routine) { create :routine, user: user }

    it 'has a valid factory' do
      exercise = build :exercise, routine: routine
      expect(exercise).to be_valid
    end

    it 'has an invalid name' do
      exercise = build :exercise, routine: routine, name: ''
      expect(exercise).not_to be_valid
      expect(exercise.errors[:name]).to include("can't be blank")
    end

    it 'has an invalid sets' do
      exercise = build :exercise, routine: routine, sets: nil
      expect(exercise).not_to be_valid
      expect(exercise.errors[:sets]).to include("can't be blank")
    end

    it 'has an invalid reps' do
      exercise = build :exercise, routine: routine, reps: nil
      expect(exercise).not_to be_valid
      expect(exercise.errors[:reps]).to include("can't be blank")
    end

    it 'has an invalid rest' do
      exercise = build :exercise, routine: routine, rest: nil
      expect(exercise).not_to be_valid
      expect(exercise.errors[:rest]).to include("can't be blank")
    end

    it 'has an invalid rempo' do
      exercise = build :exercise, routine: routine, tempo: ''
      expect(exercise).not_to be_valid
      expect(exercise.errors[:tempo]).to include("can't be blank")
    end
  end
end
