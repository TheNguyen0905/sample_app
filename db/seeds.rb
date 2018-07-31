User.create!(name: "Example User",
             email: "the123@gmail.com",
             password: "the123",
             password_confirmation: "the123",
             admin: true)

99.times do |n|
  name = FFaker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end
