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

  scope :admins, -> { where(type: 'Admin') }
  scope :teachers, -> { where(type: 'Teacher') }
  scope :students, -> { where(type: 'Student') }

  def full_name
    "#{first_name} #{last_name}"
  end
end