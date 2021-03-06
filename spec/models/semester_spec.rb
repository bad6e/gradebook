require 'rails_helper'

describe Semester do
  subject { create(:semester) }

  it { should be_valid }

  it { should respond_to(:begin_date) }
  it { should respond_to(:end_date) }

  it { should validate_presence_of(:begin_date) }
  it { should validate_presence_of(:end_date) }

  it { should validate_uniqueness_of(:begin_date) }
  it { should validate_uniqueness_of(:end_date) }

  it { should have_many(:courses) }

  it 'must have an end_date after the begin_date' do
    semester = Semester.create(begin_date: Date.today,
                               end_date: Date.today - 3.months)
    expect(semester).to be_invalid

    expect(semester.errors[:base])
      .to eq(['Semester begin date must be before end date'])
  end
end
