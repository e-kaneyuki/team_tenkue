FactoryBot.define do
  factory :post do
    content {'転クエの共同開発！！'}
    association :user
  end
end
