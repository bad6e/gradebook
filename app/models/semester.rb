class Semester < ActiveRecord::Base
  validates :begin_date, :end_date,
    presence: true

  validates :begin_date, :end_date,
    uniqueness: true

  validate :verify_end_date_is_after_begin_date

  has_many :courses

  def verify_end_date_is_after_begin_date
    if  (end_date && begin_date) && end_date <= begin_date
      errors[:base] << "Semester begin date must be before end date"
    end
  end
end
