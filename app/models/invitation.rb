require 'securerandom'

class Invitation < ApplicationRecord
  belongs_to :company

  before_save :set_expiration
  before_create :generate_code

  private

  def set_expiration
    self.expires_in = 24.hours.from_now
  end

  def generate_code
    self.code = SecureRandom.hex
  end
end
