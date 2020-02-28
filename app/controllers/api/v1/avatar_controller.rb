class Api::V1::AvatarController < ApplicationController
  def create
    @deliveryman = Deliveryman.find(params[:deliveryman_id])
    @deliveryman.avatar.attach(params[:avatar])
    json_response(@deliveryman.avatar.blob)
  end
end
