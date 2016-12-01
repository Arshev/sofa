require 'rails_helper'

feature 'User sign out', %q{
  In order to be able to sign out
  As an sing in User
  I want to be able to sign out
} do

  given(:user) { create(:user) }
  
  scenario 'Signed user try to sign out' do
    sign_in(user) #AcceptanceHelper module
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully.'
    expect(current_path).to eq root_path
  end

end