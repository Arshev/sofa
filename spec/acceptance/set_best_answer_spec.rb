require_relative 'acceptance_helper'

feature 'set Best answer', %q{
  In order to set best question
  As an author of question
  I'd like to be able to set best answer
} do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

  scenario 'Unathinticated user try set best answer' do 
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_link 'Make best'
    end
  end

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario "sees link 'Make best'" do
      within '.answers' do
        expect(page).to have_link 'Make best'
      end
    end
    scenario 'Author question try set the best of answers', js: true do
      within '.answers' do
        click_on 'Make best'
        expect(page).to_not have_link 'Make best'
      end
    end
  end

end