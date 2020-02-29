class Recipient < ApplicationRecord
  has_many :orders
  validates :name, :street, :state, :city, :zip_code, presence: true
end
