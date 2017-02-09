class Word < ApplicationRecord
  has_many :results, dependent: :destroy  
  has_many :answers
  has_many :lessons, through: :results
end
