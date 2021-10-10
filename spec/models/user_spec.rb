require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'should have valid factory' do
      user = build :user
      expect(user).to be_valid
    end

    it 'should validate presence of username and password' do
      user = build :user, username: nil, password: nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:username]).to include("can't be blank")
      expect(user.errors.messages[:password]).to include("can't be blank")
    end

    it 'should validate minimum length of username' do
      user = build :user, username: 'ivan', password: 'password'
      expect(user).not_to be_valid
      expect(user.errors.messages[:username]).to include('is too short (minimum is 5 characters)')
    end

    it 'should validate maximum length of username' do
      user = build :user, username: 'ivanqwqwqwqwqwqwqwqwqw', password: 'password'
      expect(user).not_to be_valid
      expect(user.errors.messages[:username]).to include('is too long (maximum is 20 characters)')
    end

    it 'should validate uniqueness of username' do
      user = create :user
      other_user = build :user, username: user.username
      expect(other_user).not_to be_valid
      other_user.username = 'newusername'
      expect(other_user).to be_valid
    end
  end
end
