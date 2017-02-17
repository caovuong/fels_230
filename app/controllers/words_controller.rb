class WordsController < ApplicationController
  before_action :load_word_by_word_type, only: :index

  def index
    @categories = Category.all
  end

  private
  def load_word_by_word_type
    if params[:word_type].present?
      word_type = params[:word_type] || Settings.all_word
      @words = Word.send(word_type, current_user)
        .by_category(params[:by_category])
        .paginate page: params[:page], per_page: Settings.per_page
    else
      @words = Word.all_word
    end
  end
end
