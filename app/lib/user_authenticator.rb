class UserAuthenticator
  attr_reader :access_token

  class AuthenticationError < StandardError; end

  def initialize(username: nil, password: nil)
    @username = username
    @password = password
  end

  def perform
    raise AuthenticationError if @username.blank? || @password.blank?
    raise AuthenticationError unless User.exists?(username: @username)

    user = User.find_by(username: @username)

    raise AuthenticationError unless user.password == @password

    @user = user

    set_access_token
  end

  private

  def set_access_token
    @access_token = if @user.access_token.present?
                      @user.access_token
                    else
                      @user.create_access_token
                    end
  end
end
