# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.with_attached_icon.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:icon)
  end
end
