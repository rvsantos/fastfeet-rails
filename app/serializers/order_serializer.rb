class OrderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :product, :start_date, :end_date, :canceled_at
  belongs_to :deliveryman
  belongs_to :recipient
end
