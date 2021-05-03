FactoryBot.define do
  factory :access_token do
    token { 'Access Token' }
    user { nil }
  end
end
