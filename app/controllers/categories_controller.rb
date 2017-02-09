class CategoriesController < ApplicationController
  before_action :find_category, only: [:destroy]

  def new
    @category = Category.new
  end

  def index
    @category = Category.paginate page: params[:page], per_page: 10
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

  def destroy
    if @category.destroy
      flash[:success] = "User deleted"
      redirect_to categories_url
    else
      flash[:danger] = "Xoa user that bai"
      redirect_to categories_url
    end
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def find_category
    @category = Category.find_by id: params[:id]
  end
end
