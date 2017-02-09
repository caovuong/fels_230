class CategoriesController < ApplicationController
  def new
    @category = Category.new
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

  private
  def category_params
    params.require(:category).permit :name
  end
end
