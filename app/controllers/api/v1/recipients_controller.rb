class Api::V1::RecipientsController < ApplicationController
  before_action :find_recipient, only: [:show]

  def index
    @recipients = Recipient.all
    json_response(@recipients)
  end

  def show
    json_response(@recipient)
  end

  private

  def find_recipient
    @recipient = Recipient.find(params[:id])
  end
end
