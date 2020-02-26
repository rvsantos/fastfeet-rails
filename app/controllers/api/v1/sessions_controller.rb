class Api::V1::SessionsController < ApplicationController
  skip_before_action :authorize_request

  def create
    token = AuthenticateUser.new(session_params[:email],
                                 session_params[:password]).call
    json_response({ auth_token: token }, :created)
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
