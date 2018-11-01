FactoryBot.define do
  factory :repository do
    name { Faker::Pokemon.unique.name }
    git_dir { '/na' }
    branch { '/master' }
    frequency { 'daily' }
    time { '12:00' }
    notification_emails { 'meow@example.com' }
  end
end
