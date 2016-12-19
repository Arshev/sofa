require_relative 'acceptance_helper'

feature 'set Best answer', %q{
  In order to set best question
  As an author of question
  I'd like to be able to set best answer
} do
  given(:question) { create(:question_with_answers) }
  given!(:answer) { create(:answer, question: question) }

  scenario 'Unathinticated user try set best answer', js: true do 
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_link 'Make best'
    end
  end

  describe 'Authenticated user' do

    given(:user) { question.user }

    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario "sees link 'Make best'", js: true do
      within '.answers' do
        expect(page).to have_link 'Make best'
      end
    end
    scenario 'Author question try set the best of answers', js: true do
      within '.answers' do
        click_link('Make best', match: :first)
      end
    end
  end

end