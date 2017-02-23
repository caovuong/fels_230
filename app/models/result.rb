class Result < ApplicationRecord
  belongs_to :lesson
  belongs_to :word
  belongs_to :answer, optional: true

  scope :is_corrects, ->{joins(:answer)
    .where answers: {is_correct: true}}
end
