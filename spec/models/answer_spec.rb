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

  let(:model) { answer1 }
  it_behaves_like 'Voting'

  describe '#send_notification' do
    let(:question) { create :question }
    let(:answer) { build :answer, question: question }

    it 'sends email to question owner and subscribers when answer is created' do
      expect(NotifySubscribersJob).to receive(:perform_later).with(answer, question)
      answer.save!
    end
  end
end
