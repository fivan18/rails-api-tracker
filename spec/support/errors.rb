require 'rails_helper'

shared_examples_for 'unauthorized_standard_requests' do
  let(:authentication_error) do
    {
      status: '401',
      source: { pointer: '/user/params' },
      title: 'Invalid login or password',
      detail: 'You must provide valid credentials in order to exchange them for token.'
    }
  end

  it 'should return 401 status code' do
    subject
    expect(response).to have_http_status(401)
  end

  it 'should return proper error body' do
    subject
    expect(json[:errors]).to include(authentication_error)
  end
end

shared_examples_for 'forbidden_requests' do
  let(:authorization_error) do
    {
      status: '403',
      source: { pointer: '/headers/authorization' },
      title: 'Not authorized',
      detail: 'You have no right to access this resource.'
    }
  end

  it 'should return 403 status code' do
    subject
    expect(response).to have_http_status(:forbidden)
  end

  it 'should return proper error json' do
    subject
    expect(json[:errors]).to include(authorization_error)
  end
end
