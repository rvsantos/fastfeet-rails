class Api::V1::RecipientsController < ApplicationController
  def index
    @recipients = Recipient.all
    json_response(@recipients)
  end
end
