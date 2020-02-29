class Api::V1::DeliverymansController < ApplicationController
  before_action :find_deliveryman, only: %i[show update]

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

  def show
    json_response(DeliverymanSerializer.new(@deliveryman))
  end

  def update
    @deliveryman.update!(set_params)
    json_response(serializer.new(@deliveryman))
  end
end

private

def set_params
  params.permit(:name, :email)
end

def find_deliveryman
  @deliveryman = Deliveryman.find(params[:id])
end

def serializer
  DeliverymanSerializer
end
