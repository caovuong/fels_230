class Word < ApplicationRecord
  has_many :results, dependent: :destroy  
  has_many :answers, dependent: :destroy
  has_many :lessons, through: :results
  belongs_to :category
  scope :random, -> {order "RANDOM()"}
  accepts_nested_attributes_for :answers,
    reject_if: lambda {|attribute| attribute[:content].blank?}, 
    allow_destroy: true
  validate :check_correct_answer, on: :create

  scope :all_word, ->(user_id){}
  scope :learned, ->(user_id){joins(:lessons)
    .distinct.where(lessons: {is_completed: true, user_id: user_id})}
  scope :not_learned, ->(user_id){joins(:lessons)
    .distinct.where(lessons: {is_completed: false, user_id: user_id})}
  scope :by_category, ->(category_id) do
    where category_id: category_id if category_id.present?
  end
  
  private
  def check_correct_answer
    correct_answer = answers.select {|answers| answers.is_correct?}
    errors[:base] << "need_avaliable" if correct_answer.empty?
    errors[:base] << "no_more_than_one" if correct_answer.size > Settings.max_correct_answer
  end
end
