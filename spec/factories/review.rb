FactoryBot.define do
  factory :review do
    name { "Branch #{Faker::Hipster.word} up to #{SecureRandom.hex(4)}" }
    status { 'New' }
    diff { "Test html diff. Random value: #{SecureRandom.hex(12)}" }
  end
end
