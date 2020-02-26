class Api::V1::RecipientsController < ApplicationController
  before_action :find_recipient, only: [:show]

  def index
    @recipients = Recipient.all
    json_response(@recipients)
  end

  def create
    @user = Recipient.create!(set_params)
    json_response(@user, :created)
  end

  def show
    json_response(@recipient)
  end

  private

  def set_params
    params.permit(:name, :street, :complement, :state, :city, :zip_code)
  end

  def find_recipient
    @recipient = Recipient.find(params[:id])
  end
end
