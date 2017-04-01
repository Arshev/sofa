shared_examples_for "API contains attr" do
  %w(id body created_at updated_at user_id).each do |attr|
    it "contains attribute #{attr}" do
      expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path(attr_path)
    end
  end
end