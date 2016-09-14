FactoryGirl.define do
  factory :Message do
    content { Faker::Lorem.paragraph }

  end
end