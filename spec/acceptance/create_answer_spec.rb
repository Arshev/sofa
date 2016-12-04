require 'rails_helper'

feature 'User can add answer on the question', %q{
  In order to add answer for community
  As an authenticated user
  I want to be able add answer for question
} do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user add answer' do
    sign_in(user) #AcceptanceHelper module

    visit question_path(question)
    fill_in 'Body', with: 'Test answer content'
    click_on 'Add Answer'
    save_and_open_page
    
    expect(page).to have_content ('Test answer content')
  end

  scenario 'Non-authenticated user add answer' do
    visit question_path(question)
    click_on 'Add Answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end