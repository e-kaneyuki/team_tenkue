FactoryBot.define do
  factory :user do
    sequence(:id, &:to_s)
    sequence(:email) { |n| "test#{n}@example.com" }
    name { '山田　太郎' }
    password {'1234abcd'}
  end
end
