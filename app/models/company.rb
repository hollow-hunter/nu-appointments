class Company < ApplicationRecord
  validates :name, presence: true
  has_many :users
  has_many :clients
end
