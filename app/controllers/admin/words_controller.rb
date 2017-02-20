class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :load_category
  before_action :find_word, except: [:index, :new, :create]

  def new
    @word = Word.new
    @word.category_id = params[:category_id]
    unless @word.category_id
      flash[:danger] = "Error"
      redirect_to root_url
    end

    @list_categories = list_categories
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

  def show
    @answers = @word.answers
  end
  
  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "controllers.admin.words_controller.flash_update_success"
      redirect_to :back
    else
      flash[:danger] = t "controllers.admin.words_controller.flash_update_failed"
      render :edit
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = t "controllers.admin.words_controller.flash_delete_success"
      redirect_to :back
    else
      flash[:danger] = t "controllers.admin.words_controller.flash_delete_failed"
      admin_category_path @category
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

  def list_categories
    Category.all.each.collect{|i| [i.name, i.id]}
  end

  def find_word
    @word = Word.find_by id: params[:id]
    unless @word
      flash[:danger] = t "controllers.admin.words_controller.word_not_exit"
      redirect_to admin_words_path
    end
  end
end
