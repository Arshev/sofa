require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let!(:question) { create(:question) }
  let!(:answer) { create(:answer, question: question) }
  let(:controller_type) { answer }

  it_behaves_like 'Vote controllers'
end