FactoryGirl.define do
  factory :user do
    name     "Sabrina Ulbrich"
    email    "su@xyz.de"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :cardset do
    topic "Topic"
    description "Description"
    author_id 1
  end

  factory :card do
    question "Question"
    answer "Answer"
  end
end