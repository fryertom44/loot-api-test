FactoryBot.define do
  factory :user do
    first_name "John"
    last_name  "Doe"
    sequence(:username) { |n| "person#{n}@example.com" }
    address_line_1 "12 Station Road"
    dob { 25.years.ago }
    password "testpassword"
    password_confirmation "testpassword"
  end
end
