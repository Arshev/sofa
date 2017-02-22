require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }
  it { should have_many(:attachments) }

  it { should validate_presence_of :body }
  
  it { should accept_nested_attributes_for :attachments }

  let(:question) { create(:question_with_answers) }
  let(:answer1) { question.answers[1] }
  let(:answer2) { question.answers[2] }
  let(:user) { create(:user) }

  describe 'best answer set' do
    before { answer1.set_best }
    
    it { expect(answer1.best?).to eq true }
    it { expect(answer2.best?).to be_falsey }
  end

  describe 'best answer change' do
    before do
      answer1.set_best 
      answer2.set_best 
      answer1.reload
      answer2.reload
    end
    
    it { expect(answer1.best?).to eq false }
    it { expect(answer2.best?).to eq true }
  end

  describe 'vote_up answer set' do
    before { answer1.vote_up(user) }
    
    it { expect(answer1.rating).to eq 1 }
  end

  describe 'vote_down answer set' do
    before { answer1.vote_down(user) }
    
    it { expect(answer1.rating).to eq -1 }
  end

  describe 'has_positive_vote? answer set for vote_up method' do
    before { answer1.vote_up(user) }
    
    it { expect(answer1.has_positive_vote?(user)).to eq true }
  end

  describe 'has_negative_vote? answer set for vote_up method' do
    before { answer1.vote_up(user) }
    
    it { expect(answer1.has_negative_vote?(user)).to eq false }
  end

  describe 'has_positive_vote? answer set for vote_down method' do
    before { answer1.vote_down(user) }
    
    it { expect(answer1.has_positive_vote?(user)).to eq false }
  end

  describe 'has_negative_vote? answer set for vote_down method' do
    before { answer1.vote_down(user) }
    
    it { expect(answer1.has_negative_vote?(user)).to eq true }
  end
end
