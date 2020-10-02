class Client < ApplicationRecord
  validates :name, :phone, :email, presence: true
  validates :code, uniqueness: true
end
