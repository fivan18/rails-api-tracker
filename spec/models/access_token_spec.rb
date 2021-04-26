require 'rails_helper'

RSpec.describe AccessToken, type: :model do
  describe 'new' do
    it 'should have a token present after initialize' do
      expect(AccessToken.new.token).to be_present
    end

    it 'should generate a token for the user' do
      user = create :user
      expect { user.create_access_token }.to change { AccessToken.count }.by(1)
    end
  end
end
