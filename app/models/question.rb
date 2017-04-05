class Question < ApplicationRecord
  include Votable
  include Commentable
  
  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  validates :title, :body, presence: true
  validates :title, length: { minimum: 5, maximum: 255 }

  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  after_create :subscribe_author

  private

  def subscribe_author
    subscriptions.create(user: user)
  end
end
