class Answer < ApplicationRecord
  belongs_to :word
  
  has_many :results
end
