FactoryBot.define do
  factory :comment do
    comment {'コメントしました！！'}
    association :user
    association :post
  end
end