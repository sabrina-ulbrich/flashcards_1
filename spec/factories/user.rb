FactoryGirl.define do
  factory :user do
    name     "Sabrina Ulbrich"
    email    "su@xyz.de"
    password "foobar"
    password_confirmation "foobar"
  end
end
