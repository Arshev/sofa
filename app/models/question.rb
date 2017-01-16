class Question < ApplicationRecord
  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :attachments, dependent: :destroy

  validates :title, :body, presence: true
  validates :title, length: { minimum: 5, maximum: 255 }

  accepts_nested_attributes_for :attachments
end
