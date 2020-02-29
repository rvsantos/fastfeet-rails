class Deliveryman < ApplicationRecord
  has_many :orders
  has_one_attached :avatar

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
