require_relative 'acceptance_helper'

feature 'Search', %q{
  In order to find needed information
  As a user
  I'd like to be able to search
} do
  
  given!(:user){ create(:user) }
  given!(:question){ create(:question) }
  given!(:answer){ create(:answer, question: question) }
  given!(:comment){ create(:comment, commentable: answer) }

  before do
    index
    visit root_path
  end

  scenario 'searching in everywhere', js: true do
    fill_in 'query', with: 'Test'
    select 'everywhere', from: 'object'
    click_button 'Search'

    expect(page).to have_content user.email
    expect(page).to have_content question.title
    expect(page).to have_content answer.body
    expect(page).to have_content comment.body
  end
end