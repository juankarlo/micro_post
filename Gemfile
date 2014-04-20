source 'http://0.0.0.0:8808'
# source 'https://rubygems.org'
ruby '2.1.1'
##ruby-gemset=micro_post
gem 'rails', '~>  4.0.3'

gem 'heroku'
gem 'bootstrap-sass', '~> 3.1.1'
gem 'bcrypt', '~> 3.1.7'
gem 'faker'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'squeel'
gem 'figaro'
gem 'friendly_id', '~> 5.0.0'
gem 'formtastic', '2.3.0.rc3'
gem 'formtastic-bootstrap'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman', :require => false
  gem 'quiet_assets'
  gem 'pry-rails'
  gem 'spring'
end

group :test, :development do
  gem 'sqlite3'
  gem 'rspec', '~> 2.14.0'
  gem 'rspec-rails', require: false
  gem 'spring-commands-rspec'
  gem 'factory_girl_rails'
  # The following optional lines are part of the advanced setup.
  gem 'guard-rspec' #, require: false
  gem 'spork-rails'
  gem 'guard-spork'
  gem 'guard-cucumber'
  gem 'guard-rails'
  gem 'guard-livereload', require: false
  gem 'rack-livereload'
  gem 'childprocess'
  gem 'fuubar'
end


group :test do
  gem 'selenium-webdriver'
  gem 'libnotify'
  gem 'capybara'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'email_spec'

end

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'unicorn'
end
gem 'puma'
