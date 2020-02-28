class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: %i[show update destroy]
  skip_before_action :authorize_request, only: [:create]

  def index
    @users = serializer.new(User.all.paginate(page: params[:page], per_page: 10))
    json_response(@users)
  end

  def create
    @user = serializer.new(User.create!(user_params))
    json_response(@user, :created)
  end

  def update
    @user.update!(user_params)
    json_response(serializer.new(@user))
  end

  def show
    json_response(serializer.new(@user))
  end

  def destroy
    @user.destroy
    head 204
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def serializer
    UserSerializer
  end
end
