require 'rails_helper'

describe Course do
  subject { create(:course) }

  it { should be_valid }

  it { should respond_to(:name) }
  it { should respond_to(:description) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }

  it { should belong_to(:semester) }
  it { should belong_to(:teacher) }
end