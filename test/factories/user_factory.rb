FactoryBot.define do
  factory :user do
    username { Faker::Internet.unique.username(specifier: 5..14) }
    email { Faker::Internet.unique.email }
    password { 
      Faker::Internet.password(min_length: 8) + Faker::Number.digit.to_s
    }
  end
end
