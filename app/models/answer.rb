class Answer < ApplicationRecord

  include Votable
  include Commentable
  
  belongs_to :user
  belongs_to :question
  has_many :attachments, as: :attachmentable, dependent: :destroy


  validates :body, presence: true
  validates :body, length: { minimum: 5, maximum: 255 }

  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  default_scope { order("best DESC, created_at") }

  def set_best
    Answer.transaction do
      question.answers.update_all(best:false)
      raise ActiveRecord::Rollback unless question.answers.where(best: true).first.nil?
      update!(best:true)
    end  
  end

  
end
