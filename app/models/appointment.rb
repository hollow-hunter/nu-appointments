class Appointment < ApplicationRecord
  enum status: %i[pending done cancelled]
  belongs_to :client
  belongs_to :staff
  validates :date, :end_time, :start_time, :status, presence: true
  validate :time_range

  def check_company(user_company_id)
    return true if client_id.nil? || staff_id.nil?

    c = Client.find(client_id)
    s = Staff.find(staff_id)
    staff_validity = s.company_id == user_company_id
    client_validity = c.company_id == user_company_id
    errors.add(:staff_id, 'staff is not valid') unless staff_validity
    errors.add(:client_id, 'client is not valid') unless client_validity
    staff_validity && client_validity
  end

  private

  def time_range
    return if end_time.nil? || start_time.nil?

    errors.add(:end_time, "end time can't be lesser than the start time") if end_time < start_time
  end
end
