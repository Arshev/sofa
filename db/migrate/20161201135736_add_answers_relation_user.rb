class AddAnswersRelationUser < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :answers, :user, index: true
  end
end
