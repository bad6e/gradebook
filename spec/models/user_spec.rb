require 'rails_helper'

describe User do
  subject { create(:user) }

  it { should be_valid }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:type) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_confirmation) }

  it { should have_secure_password }

  it { should validate_uniqueness_of(:email) }

  it do
    should validate_length_of(:password).
    is_at_least(6).
      on(:create)
  end
end