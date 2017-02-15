class Admin::WordsController < ApplicationController
  before_action :load_category, only: [:create]
  before_action :logged_in_user

  def new
    @word = Word.new
    @word.category_id = params[:category_id]
    unless @word.category_id
      flash[:danger] = "Error"
      redirect_to root_url
    end

    @list_category = list_category
  end

  def create
    @word = @category.words.new word_params
    if @word.save!
      flash[:success] = t "controllers.admin.words_controller.flash_add_success"
      redirect_to admin_category_path @category
    else
      flash[:danger] = t "controllers.admin.words_controller.flash_add_error"
      render :new
    end
  end  
  
  private
  def word_params
    params.require(:word).permit :name, :category_id, :content,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def load_category
    @category = if params[:category_id] 
      Category.find_by id: params[:category_id] 
    else
      Category.find_by id: params[:word][:category_id] 
    end
  end

  def list_category
    Category.all.each.collect{|i| [i.name, i.id]}
  end
end
