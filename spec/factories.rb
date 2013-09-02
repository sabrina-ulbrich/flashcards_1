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
  	user
  end
end