class Question < ApplicationRecord
  belongs_to :user

  has_many :answers, dependent: :destroy

  validates :title, :body, presence: true
  validates :title, length: { minimum: 5, maximum: 255 }
end
