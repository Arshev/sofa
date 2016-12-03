FactoryGirl.define do

  sequence :title do |n|
    "Question #{n + rand(100..1000)}"
  end

  sequence :body do |n|
    "Test content #{n + rand(100..1000)}"
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
