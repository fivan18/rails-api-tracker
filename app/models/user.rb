class User < ApplicationRecord
  include BCrypt
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

  def password
    @password ||= Password.new(encrypted_password) if encrypted_password.present?
  end

  def password=(new_password)
    if new_password.blank?
      @password = new_password
    else
      @password = Password.create(new_password)
      self.encrypted_password = @password
    end
  end
end
