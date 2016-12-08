require_relative 'acceptance_helper'

feature 'User can add answer on the question', %q{
  In order to add answer for community
  As an authenticated user
  I want to be able add answer for question
} do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Authenticated user add answer', js: true do
    sign_in(user) #AcceptanceHelper module

    visit question_path(question)
    fill_in 'Body', with: 'Test answer content'
    click_on 'Add Answer'
    
    within '.answers' do
    expect(page).to have_content ('Test answer content')
    end
  end

  scenario 'Non-authenticated user add answer' do
    visit question_path(question)
    click_on 'Add Answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'User try to create invalid answer', js: true do
    sign_in(user) #AcceptanceHelper module

    visit question_path(question)
    click_on 'Add Answer'

    expect(page).to have_content "Body can't be blank"
  end
end