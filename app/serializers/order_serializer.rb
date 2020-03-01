class OrderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :product
  belongs_to :deliveryman
  belongs_to :recipient
end
