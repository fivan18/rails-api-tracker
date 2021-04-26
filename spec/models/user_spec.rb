require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validations' do
    it 'should have valid factoy' do
      user = build :user
      expect(user).to be_valid
    end

    it 'should validate presence of username and password' do
      user = build :user, username: nil, password: nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:username]).to include("can't be blank")
      expect(user.errors.messages[:password]).to include("can't be blank")
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
