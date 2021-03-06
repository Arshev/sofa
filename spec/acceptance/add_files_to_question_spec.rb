require_relative 'acceptance_helper'

feature 'Add files to question', %q{
  In order to illustrate my question
  As an author of question
  I'd like to be able to attach files
} do
  
  given(:user) { create (:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User add file when ask question', js: true do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test content'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Add file'
    within all('.nested-fields').first do
      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
    end

    click_on 'Create'

    expect(page).to have_content 'spec_helper.rb'
    expect(page).to have_content 'rails_helper.rb'
  end

end