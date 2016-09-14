FactoryGirl.define do
  factory :Player do
    nickname { Faker::Name.name }

  end
end
