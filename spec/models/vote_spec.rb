require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to :user }
  it { should belong_to :votable }

  describe 'votable answer method tests' do
    let(:question) { create(:question_with_answers) }
    let(:user) { create(:user) }
    let(:answer) { question.answers[1] }

    context 'vote_up answer set' do
      before { answer.vote_up(user) }
      
      it { expect(answer.rating).to eq 1 }
    end

    context 'vote_down answer set' do
      before { answer.vote_down(user) }
      
      it { expect(answer.rating).to eq -1 }
    end

    context 'has_positive_vote? answer set' do
      before { answer.vote_up(user) }
      
      it { expect(answer.has_positive_vote?(user)).to eq true }
      it { expect(answer.has_negative_vote?(user)).to eq false }
    end
  end
end
