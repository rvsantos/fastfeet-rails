class Recipient < ApplicationRecord
  has_many :orders, dependent: :destroy
  validates :name, :street, :state, :city, :zip_code, presence: true
end
