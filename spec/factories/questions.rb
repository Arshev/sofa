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

  factory :question_with_answers, class: "Question" do
    user
    title
    body 'Test content in question with answer'
    after(:create) do |question|
      create_list(:answer, 5, question: question)
    end
  end
end
