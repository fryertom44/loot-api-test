# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@admin = User.create!(
  username: "admin@example.com",
  password: "Admin12345",
  password_confirmation: "Admin12345",
  first_name: "Tom",
  last_name: "Fryer",
  dob: "1979-04-04",
  address_line_1: "3 Shoreham Rise"
)
@users = []
5.times do |x|
  @users << User.create!(
    username: "user#{x}@example.com",
    password: "User12345",
    password_confirmation: "User12345",
    first_name: "Tom",
    last_name: "Fryer",
    dob: "1979-04-04",
    address_line_1: "3 Shoreham Rise"
  )
end
