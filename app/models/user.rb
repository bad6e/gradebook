class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, :last_name, :email,
    presence: true

  validates :email,
    uniqueness: true

  validates_length_of :password, minimum: 6, on: :create

  validates :password_confirmation,
    presence: true
end
