require_relative 'acceptance_helper'

feature 'answer editing', %q{
  In order to fix mistake
  As an author of answer
  I'd like to be able to edit my answer
} do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

  scenario 'Unathinticated user try edit answer' do 
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_link 'Edit'
    end
  end

  describe 'Authenticated user' do
    before do
      sign_in(answer.user)
      visit question_path(question)
    end

    scenario "sees link 'Edit'" do
      within '.answers' do
        expect(page).to have_link 'Edit'
      end
    end
    scenario 'Author try edit his answer', js: true do
      within '.answers' do
        click_on 'Edit'
        fill_in 'Answer', with: 'edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end
  end

  describe 'Authenticated user, not author', js: true do
    scenario "try edit other author's answer" do
      sign_in(user2)
      visit question_path(question)
      within '.answers' do
        expect(page).to_not have_link 'Edit'
      end
    end
  end
end