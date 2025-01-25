FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    # emailカラムのユニーク制約（複数のレコードで同じ値を持つことができない）を考慮しているため
    # sequence(:email) { |n| "#{n}_" + "test@example.com" }
    sequence(:email) { |n| "#{n}_" + Faker::Internet.email }
    password { Faker::Internet.password(min_length: 10) }
    confirmed_at { Time.current }
  end
end
