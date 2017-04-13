require 'rails_helper'

RSpec.describe Search do
  describe '.find' do
   
    let(:user) { create(:user) }
    let!(:question) { create(:question, user: user) }
    let(:search) { create(:search) }
    let!(:query) { ThinkingSphinx::Query.escape(search.query) }

    it 'global search when scope not defined' do
      expect(ThinkingSphinx).to receive(:search).with(query)
      search.find
    end

    # it 'searches for specific models when scope defined' do
    #   search.scope = 'questions'
    #   expect(Question).to receive(:search).with(query)
    #   search.run
    # end

    # it 'stores search results in @result' do
    #   allow(ThinkingSphinx).to receive(:search).and_return([question])
    #   search.run
    #   expect(search.result).to eq([question])
    # end
  end
end