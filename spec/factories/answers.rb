FactoryGirl.define do
  factory :answer do
    user
    body "MyText"
  end
  factory :invalid_answer, class: "Answer" do
    user
    body nil
  end
end
