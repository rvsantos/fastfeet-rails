class Api::V1::DeliverymansController < ApplicationController
  def index
    @deliveryman = DeliverymanSerializer.new(
      Deliveryman.all.with_attached_avatar
    ).serializable_hash
    json_response(@deliveryman)
  end

  def create
    @deliveryman = DeliverymanSerializer.new(Deliveryman.create!(set_params))
    json_response(@deliveryman, :created)
  end
end

private

def set_params
  params.permit(:name, :email)
end

def serializer
  DeliverymanSerializer
end
