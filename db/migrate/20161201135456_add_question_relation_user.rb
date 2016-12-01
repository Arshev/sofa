class AddQuestionRelationUser < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :questions, :user, index: true
  end
end
