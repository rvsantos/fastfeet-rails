class Api::V1::OrdersController < ApplicationController
  before_action :find_recipient, :find_deliveryman, only: [:create]
  before_action :find_order, only: %i[show update destroy]
  before_action :set_options_serializer, except: [:destroy]
  before_action :business_hour, only: [:withdrawal]

  def index
    @orders = serializer.new(Order.all, @options).serializable_hash
    json_response(@orders)
  end

  def create
    @order = Order.new(order_params)
    @order.deliveryman = @deliveryman
    @order.recipient = @recipient
    @order.save!
    json_response(serializer.new(@order, @options).serialized_json, :created)
  end

  def update
    @order.deliveryman = @deliveryman if @deliveryman
    @order.recipient = @recipient if @recipient
    @order.update!(order_params)
    json_response(serializer.new(@order, @options))
  end

  def show
    json_response(serializer.new(@order, @options))
  end

  def destroy
    @order.destroy
    head 204
  end

  def withdrawal
    @order = Order.find(params[:order_id])
    @order.start_date = Time.zone.now
    @order.save
    json_response(serializer.new(@order, @options))
  end

  private

  def business_hour
    now = Time.zone.now
    eight_morning = DateTime.new(now.year, now.month, now.day, 8, 0, 0, now.zone)
    eighteen_night = DateTime.new(now.year, now.month, now.day, 18, 0, 0, now.zone)
    if (now < eight_morning) || (now > eighteen_night)
      render json: { error: 'Allowed withdrawn only 8 am as 6 pm' }, status: :bad_request
    end
  end

  def find_recipient
    @recipient = Recipient.find(order_params[:recipient_id])
  end

  def find_deliveryman
    @deliveryman = Deliveryman.find(order_params[:deliveryman_id])
  end

  def find_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.permit(:product, :recipient_id, :deliveryman_id)
  end

  def set_options_serializer
    @options = { include: %i[recipient deliveryman] }
  end

  def serializer
    OrderSerializer
  end
end
