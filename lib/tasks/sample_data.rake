namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    admin = User.create!(name: 'Juan C. Nieves', email: 'juanc.nieves@gmail.com', password: '123456', password_confirmation: '123456')
    admin.toggle!(:admin)
    99.times do |n|
      name = Faker::Name.name
      #email = "#{name.parameterize}@railstutorial.org"
      email = "example-#{n+1}@railstutorial.org"
      password = 'password'
      User.create!(name: name, email: email, password: password,
                   password_confirmation: password)
    end
  end
end
