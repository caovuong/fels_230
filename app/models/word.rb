class Word < ApplicationRecord
  has_many :results, dependent: :destroy  
  has_many :answers, dependent: :destroy
  has_many :lessons, through: :results
  belongs_to :category
  accepts_nested_attributes_for :answers,
    reject_if: lambda {|attribute| attribute[:content].blank?}, 
    allow_destroy: true

  scope :all_word, ->(user_id){}
  scope :learned, ->(user_id){joins(:lessons)
    .distinct.where(lessons: {is_completed: true, user_id: user_id})}
  scope :not_learned, ->(user_id){where.not id: Word.learned(user_id)}
  scope :by_category, ->(category_id) do
    where category_id: category_id if category_id.present?
  end
end
