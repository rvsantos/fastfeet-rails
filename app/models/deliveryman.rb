class Deliveryman < ApplicationRecord
  validates :name, :email, presence: true
end
