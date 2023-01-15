# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin.create!(
#   email: ENV['LOGIN_MAIL'],
#   password: ENV['LOGIN_PASSWORD']
# )

# 管理者登録
admins = [
  {email: ENV['LOGIN_MAIL'], password: ENV['LOGIN_PASSWORD']}
]

admins.each do |admin|
  admin_data = Admin.find_by(admin[:email])
  if admin_data.nil?
    Admin.create(email: admin[:email], password: [:password])
  end
end

# エリア
# areas = [
#   {name: '北海道', english_name: 'Hokkaido'},
#   {name: '北海道', english_name: 'Hokkaido'},
# ]

# areas.each do |area|
#   Area.find_or_create_by(name: area[:name], english_name: area[:english_name])
# end