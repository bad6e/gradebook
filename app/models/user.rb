class User < ActiveRecord::Base
  has_secure_password

  def self.types
    %w(Admin Teacher Student)
  end

  validates :first_name, :last_name, :email,
            presence: true

  validates :email,
            uniqueness: true

  validates_length_of :password, minimum: 6, on: :create

  validates :password_confirmation,
            presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    type == 'Admin'
  end

  def teacher?
    type == 'Teacher'
  end

  def student?
    type == 'Student'
  end
end
