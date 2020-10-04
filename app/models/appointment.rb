class Appointment < ApplicationRecord
  enum status: %i[pending done cancelled]
  belongs_to :client
  belongs_to :staff
  validates :date, :end_time, :start_time, :status, presence: true
  validate :time_range

  private

  def time_range
    return if end_time.nil? || start_time.nil?

    errors.add(:end_time, "end time can't be lesser than the start time") if end_time < start_time
  end
end
