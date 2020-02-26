class Api::V1::RecipientsController < ApplicationController
  before_action :find_recipient, only: %i[show update destroy]

  def index
    @recipients = serializer.new(Recipient.all.paginate(page: params[:page], per_page: 10))
    json_response(@recipients)
  end

  def create
    @recipient = serializer.new(Recipient.create!(set_params))
    json_response(@recipient, :created)
  end

  def update
    @recipient.update!(set_params)
    json_response(serializer.new(@recipient))
  end

  def show
    json_response(serializer.new(@recipient))
  end

  def destroy
    @recipient.destroy
    head 204
  end

  private

  def set_params
    params.permit(:name, :street, :complement, :state, :city, :zip_code)
  end

  def find_recipient
    @recipient = Recipient.find(params[:id])
  end

  def serializer
    RecipientSerializer
  end
end
