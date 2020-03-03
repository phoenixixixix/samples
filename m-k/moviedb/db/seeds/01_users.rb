# frozen_string_literal: true

User.create!(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)
User.create!(
  email: 'user@example.com',
  password: 'password',
  password_confirmation: 'password'
)
(1..20).each do |index|
  User.create!(
    email: "user#{index}@example.com",
    password: 'password',
    password_confirmation: 'password'
  )
end
