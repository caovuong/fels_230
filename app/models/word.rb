class Word < ApplicationRecord
  has_many :results, dependent: :destroy  
  has_many :answers, dependent: :destroy
  has_many :lessons, through: :results
  belongs_to :category
  accepts_nested_attributes_for :answers,
    reject_if: lambda {|attribute| attribute[:content].blank?}, 
    allow_destroy: true
end
