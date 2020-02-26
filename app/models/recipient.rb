class Recipient < ApplicationRecord
  validates :name, :street, :state, :city, :zip_code, presence: true
end
