class Order < ApplicationRecord
  belongs_to :recipient
  belongs_to :deliveryman

  validates :product, presence: true
end
