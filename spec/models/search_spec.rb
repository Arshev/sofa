require 'rails_helper'

RSpec.describe Search, type: :sphinx do
  describe '.find' do
    
    let(:query) { 'Test' }

    it 'receive data' do
        ts_query = ThinkingSphinx::Query.escape(query)
        expect(ThinkingSphinx::Query).to receive(:escape).with(query).and_call_original
        expect(ThinkingSphinx).to receive(:search).with(ts_query)
        Search.find(query, "everywhere")
    end
  end

  describe "Invalid params" do    
    it 'returns empty arr if context is invalid' do
      expect(Search.find('', 'else')).to match_array []
    end
  end
end