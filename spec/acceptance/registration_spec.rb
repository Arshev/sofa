require 'rails_helper'

feature 'Гser can create an account', %q{
  In order to be able to create an account
  As an non-registred User
  I want to be able to create an account
} do

  
  scenario 'User try to sign up with proper data' do
    visit new_user_registration_path
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(current_path).to eq root_path
  end

end