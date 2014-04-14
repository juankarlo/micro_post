FactoryGirl.define do
  factory :user do
    #name 'Juan C. Nieves'
    #email 'juanc.nieves@example.net'
    sequence(:name) { |n| "Person #{n}"}
    sequence(:email) { |n| "person-#{n}@example.com"}
    password 'foobar'
    password_confirmation 'foobar'

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "All stars capture neutral, ancient nanomachines."
    user
  end
end
