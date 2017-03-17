require_relative 'acceptance_helper'

feature 'Add files to answer', %q{
  In order to illustrate my answer
  As an author of answer
  I'd like to be able to attach files
} do
  
  given(:user) { create (:user) }
  given(:question) { create (:question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User add file in answer', js: true do
    within '.answers' do
      fill_in 'Body', with: 'Test answer content'
      attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
      click_on '+ Add file'
      within all('.nested-fields').first do
        attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
      end
      click_on 'Add Answer'
    end

    within '.answers' do
      expect(page).to have_content 'spec_helper.rb'
      expect(page).to have_content 'rails_helper.rb'    
    end
  end

end