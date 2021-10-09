require 'rails_helper'

RSpec.describe AccessToken, type: :model do
  describe 'new' do
    let(:user) { create :user }

    it 'should have a token present after initialize' do
      access_token = build :access_token, user:user
      expect(access_token.token).to be_present
    end

    it 'should generate a token for the user' do
      expect { user.create_access_token }.to change { AccessToken.count }.by(1)
    end

    it 'should generate token once' do
      access_token = user.create_access_token
      expect(access_token.token).to eq(access_token.reload.token)
    end
  end
end
