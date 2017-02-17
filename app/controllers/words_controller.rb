class WordsController < ApplicationController
  def index
    @categories = Category.all
    @words = Word.send(word_type, current_user)
     .by_category(params[:by_category])
     .paginate page: params[:page], per_page: Settings.per_page
  end

  private
  def word_type
  	params[:word_type] || Settings.all_word
  end
end
