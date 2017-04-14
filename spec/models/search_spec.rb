require 'rails_helper'

RSpec.describe Search, type: :sphinx do
  describe 'Searching with true params' do
    
    let(:query) { 'Test' }

    it 'Searching for object everywhere' do
        ts_query = ThinkingSphinx::Query.escape(query)
        expect(ThinkingSphinx::Query).to receive(:escape).with(query).and_call_original
        expect(ThinkingSphinx).to receive(:search).with(ts_query)
        Search.find(query, "everywhere")
    end

    it 'Searching for object questions' do
        ts_query = ThinkingSphinx::Query.escape(query)
        expect(ThinkingSphinx::Query).to receive(:escape).with(query).and_call_original
        expect(Question).to receive(:search).with(ts_query)
        Search.find(query, "questions")
    end

    it 'Searching for object answers' do
        ts_query = ThinkingSphinx::Query.escape(query)
        expect(ThinkingSphinx::Query).to receive(:escape).with(query).and_call_original
        expect(Answer).to receive(:search).with(ts_query)
        Search.find(query, "answers")
    end

    it 'Searching for object comments' do
        ts_query = ThinkingSphinx::Query.escape(query)
        expect(ThinkingSphinx::Query).to receive(:escape).with(query).and_call_original
        expect(Comment).to receive(:search).with(ts_query)
        Search.find(query, "comments")
    end

    it 'Searching for object users' do
        ts_query = ThinkingSphinx::Query.escape(query)
        expect(ThinkingSphinx::Query).to receive(:escape).with(query).and_call_original
        expect(User).to receive(:search).with(ts_query)
        Search.find(query, "users")
    end
  end

  describe "Invalid params" do    
    it 'returns empty arr if query is invalid' do
      expect(Search.find('', 'else')).to match_array []
    end

    it 'returns empty arr if context is invalid' do
      expect(Search.find('test', '')).to match_array []
    end
  end
end