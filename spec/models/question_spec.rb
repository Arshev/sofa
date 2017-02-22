require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:attachments).dependent(:destroy) }
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_length_of(:title).is_at_least(5) }
  it { should validate_length_of(:title).is_at_most(255) }
  it { should accept_nested_attributes_for :attachments }

  let(:question) { create(:question) }
  let(:user) { create(:user) }

  describe 'vote_up answer set' do
    before { question.vote_up(user) }
    
    it { expect(question.rating).to eq 1 }
  end

  describe 'vote_down answer set' do
    before { question.vote_down(user) }
    
    it { expect(question.rating).to eq -1 }
  end

  describe 'has_positive_vote? answer set for vote_up method' do
    before { question.vote_up(user) }
    
    it { expect(question.has_positive_vote?(user)).to eq true }
  end

  describe 'has_negative_vote? answer set for vote_up method' do
    before { question.vote_up(user) }
    
    it { expect(question.has_negative_vote?(user)).to eq false }
  end

  describe 'has_positive_vote? answer set for vote_down method' do
    before { question.vote_down(user) }
    
    it { expect(question.has_positive_vote?(user)).to eq false }
  end

  describe 'has_negative_vote? answer set for vote_down method' do
    before { question.vote_down(user) }
    
    it { expect(question.has_negative_vote?(user)).to eq true }
  end
end
