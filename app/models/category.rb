class Category < ApplicationRecord
  has_many :lessons, dependent: :destroy
  validates :name, presence: true, length: {maximum: 150}
end
