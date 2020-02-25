class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user }, status: :unprocessable_entity
    end
  end

  def show
    render json: @user, status: :ok
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    head 404
  end
end
