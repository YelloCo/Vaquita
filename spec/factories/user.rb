FactoryBot.define do
  factory :user do
    email { Faker::Name.unique.first_name.downcase + '@example.com' }
    password { SecureRandom.base64(10) }
  end
end
