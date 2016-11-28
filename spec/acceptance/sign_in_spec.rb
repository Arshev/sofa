require 'rails_helper'

feature 'User sign in', %q{
  In order to be able to sign in
  As an User
  I want to be able to sign in
} do
  
  scenario 'Registred user try to sign in' do
    User.create!(email: 'test@test.ru', password: '12345678')

    visit new_user_session_path
    fill_in 'Email', with: 'test@test.ru'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registred user try to signed in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@test.ru'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Invalid email or password.'
    expect(current_path).to eq new_user_session_path
  end

end