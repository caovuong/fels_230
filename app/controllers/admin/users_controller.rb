class Admin::UsersController < ApplicationController
  before_action :logged_in_user, :verify_admin

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
