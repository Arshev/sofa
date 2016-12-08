FactoryGirl.define do

  sequence :title do |n|
    "Question #{n}"
  end

  sequence :body do |n|
    "Test content 1"
  end

  factory :question do
    user
    title
    body
  end

  factory :invalid_question, class: "Question" do
    user
    title nil
    body nil
  end
end
