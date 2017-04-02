require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  let!(:question) { create(:question) }
  let(:controller_type) { question }

  it_behaves_like 'Vote controllers'
end