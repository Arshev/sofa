shared_examples_for 'Voting' do
  describe 'vote_up answer set' do
    before { model.vote_up(user) }
    
    it { expect(model.rating).to eq 1 }
  end

  describe 'vote_down answer set' do
    before { model.vote_down(user) }
    
    it { expect(model.rating).to eq -1 }
  end

  describe 'has_positive_vote? answer set for vote_up method' do
    before { model.vote_up(user) }
    
    it { expect(model.has_positive_vote?(user)).to eq true }
  end

  describe 'has_negative_vote? answer set for vote_up method' do
    before { model.vote_up(user) }
    
    it { expect(model.has_negative_vote?(user)).to eq false }
  end

  describe 'has_positive_vote? answer set for vote_down method' do
    before { model.vote_down(user) }
    
    it { expect(model.has_positive_vote?(user)).to eq false }
  end

  describe 'has_negative_vote? answer set for vote_down method' do
    before { model.vote_down(user) }
    
    it { expect(model.has_negative_vote?(user)).to eq true }
  end
end