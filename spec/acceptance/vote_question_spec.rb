require_relative 'acceptance_helper'

feature 'Vote question', '
  In order to vote question
  As an authenticated user
  I want to be able to vote question
' do

  given!(:question) { create(:question) }

  context 'Authenticated user' do
    let(:user) { create(:user) }

    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'Vote + for question', js: true do
      click_on '+'

      within '.question-voting' do
        expect(page).to have_content '1'
      end
    end

    scenario 'Vote - for question', js: true do
      click_on '-'

      within '.question-voting' do
        expect(page).to have_content '-1'
      end
    end

    scenario 'can choose cancel vote for the question', js: true do
      click_on '+'
      click_on 'cancel'
      within '.question-voting' do
        expect(page).to have_content 'You have not voted'
      end
    end
  end

  context 'Non-authenticated user' do
    before do
      visit question_path(question)
    end

    scenario 'User try to vote up an question', js: true do
      within '.question-voting' do
        expect(page).not_to have_content('+1')
      end
    end
  end
end