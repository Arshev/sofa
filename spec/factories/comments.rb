FactoryGirl.define do
  sequence :comment_body do |n|
    "Comment #{n}"
  end
  factory :comment do
    body 'Comment'
    user
    association :commentable, factory: :question

    factory :invalid_comment do
      body nil
    end
  end
end
