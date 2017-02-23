class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :user
  
  has_many :results, dependent: :destroy
  has_many :words, through: :results
  has_many :answers, through: :results

  accepts_nested_attributes_for :results

  validate :validate_word
  
  before_create :random_words
  scope :order_by_id, ->{order id: :desc}

  def answers
    answer_ids = self.results.map{|result| result.answer_id}
    Answer.where id: answer_ids
  end

  private
  def random_words
    self.words = if category.words.size >= Settings.result_size
      category.words.random.limit Settings.result_size
    end
  end

  def validate_word
    if category.words.size < Settings.result_size
      errors[:base] << ""
    end
  end
end
