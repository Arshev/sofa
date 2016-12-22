require_relative 'acceptance_helper'

feature 'set Best answer', %q{
  In order to set best question
  As an author of question
  I'd like to be able to set best answer
} do
  given(:user) { create(:user) }
  given(:question) { create(:question_with_answers) }
  

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

        expect(page).to have_link 'Make best', count: 4
        expect(page).to have_css '#best-answer', count: 1
      end
    end
  end

  describe "Non-author of question try set best answer" do
    given!(:question)    { create(:question, user_id: user.id) }
    given!(:answer)     { create_list(:answer, 2, user: user, question: question) }

    scenario 'can not see best answer link' do
      visit question_path(question)
      expect(page).to_not have_link 'Make best'
    end
  end

end