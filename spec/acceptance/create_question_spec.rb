require_relative 'acceptance_helper'

feature 'Create user question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able ask question
} do

  given(:user) { create(:user) }
  
  scenario 'Authenticated user creates question' do
    sign_in(user) #AcceptanceHelper module

    visit questions_path
    click_on 'Ask Question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test content'
    click_on 'Create'

    expect(page).to have_content 'Test content'
  end

  scenario 'Non-authenticated user tryes to create question' do
    visit questions_path
    click_on 'Ask Question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end