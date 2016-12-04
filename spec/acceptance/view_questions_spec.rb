require 'rails_helper'

feature 'User can view questions', %q{
  In order to view list of a questions
  As an authenticated and non-authenticated user
  I want to view list of a questions
} do
  given!(:questions) { create_list(:question, 3) }

  scenario 'User can view list of a questions' do
    visit questions_path
    expect(page).to have_content('Test content 1')
  end
end