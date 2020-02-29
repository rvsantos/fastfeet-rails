class Api::V1::DeliverymansController < ApplicationController
  before_action :find_deliveryman, only: %i[show update destroy]

  def index
    @deliveryman = serializer.new(
      Deliveryman.all.with_attached_avatar
    ).serializable_hash
    json_response(@deliveryman)
  end

  def create
    @deliveryman = serializer.new(Deliveryman.create!(set_params))
    json_response(@deliveryman, :created)
  end

  def show
    json_response(serializer.new(@deliveryman))
  end

  def update
    @deliveryman.update!(set_params)
    json_response(serializer.new(@deliveryman))
  end

  def destroy
    @deliveryman.destroy
    @deliveryman.avatar.purge
    head 204
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
