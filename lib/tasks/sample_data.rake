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

    users = User.all(limit: 6)
    25.times do
      content = Faker::Lorem.sentence(5)
      users.each do |user|
        #user.microposts.create(content: content, created_at: ((rand(1..10).days.ago) + rand(8..18).hour + rand(0..60).minutes).to_datetime )
        user.microposts.create(content: content, created_at: ((rand(1..60)
        .days.ago) + rand(0..18).hour + rand(0..60).minutes).to_datetime)
        user.microposts.create(content: content, created_at: (rand(0..72)
        .hour.ago + rand(0..60).minutes+ rand(0..60).seconds).to_datetime)
        user.microposts.create(content: content, created_at: (rand(0..60)
        .minutes.ago + rand(0..60).seconds).to_datetime)
        user.microposts.create(content: content, created_at: (rand(0..60)
        .seconds.ago).to_datetime)
      end
    end

  end
end

