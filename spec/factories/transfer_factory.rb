FactoryBot.define do
  factory :transfer do
    account_number_from 123456789
    account_number_to 987654321
    amount_pennies 123
    country_code_from "GBR"
    country_code_to "USA"
    association :user, factory: :user
  end
end
