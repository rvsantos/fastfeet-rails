class Api::V1::DeliverymansController < ApplicationController
  def create
    @deliveryman = Deliveryman.new(set_params)

    if @deliveryman.save
      json_response(@deliveryman, :created)
    else
      @deliveryman.avatar.purge
      json_response({ errors: @deliveryman }, 422)
    end
  end

  private

  def set_params
    params.permit(:name, :email, :avatar)
  end
end
