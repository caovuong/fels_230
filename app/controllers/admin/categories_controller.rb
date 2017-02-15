class Admin::CategoriesController < ApplicationController
  before_action :find_category, except: [:index, :new, :create]
  before_action :logged_in_user, only: [:create, :edit, :update]
  
  def new
    @category = Category.new
  end

  def index
    @category = Category.paginate page: params[:page], per_page: Settings.per_page
  end
  
  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "controllers.categories_controller.create_success"
      redirect_to root_url
    else
      render :new
    end
  end
  
  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "controllers.categories_controller.flash_update_success"
      redirect_to admin_categories_url
    else
      flash[:danger] = t "controllers.categories_controller.flash_update_error"
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:success] = t "controllers.categories_controller.flash_delete_success"
    redirect_to admin_categories_url
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def find_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = "Category not exist"
      redirect_to admin_categories_path
    end
  end
end
