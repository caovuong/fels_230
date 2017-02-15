class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :find_user, only: [:update, :edit, :show]
  before_action :correct_user, only: [:edit, :update] 
  
  def new
    @user = User.new
  end

  def index
    @users = User.paginate page: params[:page]
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t "views.pages.home.welcom_system"
      redirect_to @user
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "error.update_suc"
      redirect_to @user
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
      redirect_to users_url
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user == @user
  end
end
