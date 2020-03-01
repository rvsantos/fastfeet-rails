class Api::V1::OrdersController < ApplicationController
  before_action :find_recipient, only: [:create]
  before_action :find_deliveryman, only: [:create]

  def create
    @order = Order.new(order_params)
    @order.deliveryman = @deliveryman
    @order.recipient = @recipient
    @order.save!
    json_response(serializer.new(@order).serialized_json, :created)
  end

  private

  def find_recipient
    @recipient = Recipient.find(order_params[:recipient_id])
  end

  def find_deliveryman
    @deliveryman = Deliveryman.find(order_params[:deliveryman_id])
  end

  def order_params
    params.permit(:product, :recipient_id, :deliveryman_id)
  end

  def serializer
    OrderSerializer
  end
end
