class Admin::UsersController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :find_user, only: [:destroy, :update, :edit]

  def index
    @users = User.admin.paginate page: params[:page]
  end

  def destroy
    if @user.destroy
      flash[:success] = t "error.destroy_user"
    else
      flash[:danger] = t "error.destroy_err"
    end
    redirect_to admin_users_url
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "error.update_suc"
      redirect_to admin_root_url
    else
      flash[:danger] = t "error.update_er"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:warning] = t "error.user"
      redirect_to admin_users_url
    end
  end
end
