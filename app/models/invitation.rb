class Invitation < ApplicationRecord
  belongs_to :company

  before_save :set_expiration

  private

  def set_expiration
    self.expires_in = 24.hours.from_now
  end
end
