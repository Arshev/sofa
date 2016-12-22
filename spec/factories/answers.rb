FactoryGirl.define do

  sequence :answer_body do |n|
    "Answer #{n}"
  end

  factory :answer do
    user
    body
  end

  factory :answer_best do
    user
    answer_body
  end

  factory :invalid_answer, class: "Answer" do
    user
    body nil
  end
end
