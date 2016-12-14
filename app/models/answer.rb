class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :body, presence: true
  validates :body, length: { minimum: 5, maximum: 255 }

  default_scope { order(best: :desc) }

  def set_best
  
  end

  
end
