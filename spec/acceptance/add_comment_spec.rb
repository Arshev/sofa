require_relative 'acceptance_helper'

feature 'Add comments to question and answer', %q{
  In order to comment question and answer
  As a user
  I'd like to be able to add comments
} do
  
  given(:user) { create (:user) }
  given(:question) { create (:question_with_answers) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User add comment in question', js: true do
    within '.question-comments' do
      fill_in 'Body', with: 'Test comment content for question'
      click_on 'Add comment'
    end
    within '.question-comments' do
      expect(page).to have_content 'Test comment content for question'   
    end
  end

  scenario 'User add comment in answer', js: true do
    within '#add-comment-to-answer-1' do
      fill_in 'Body', with: 'Test comment content for answer'
      click_on 'Add comment'
    end
    within '#add-comment-to-answer-1' do
      expect(page).to have_content 'Test comment content for answer'   
    end
  end
end