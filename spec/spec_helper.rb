require 'rubygems'
require 'spork'
require 'factory_girl_rails'
require 'database_cleaner'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  #require 'capybara/rspec'
  require 'rspec/rails'
  require 'rspec/autorun'


  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

  RSpec.configure do |config|



    config.infer_base_class_for_anonymous_controllers = false

    config.order = "random"
    # Include the Capybara DSL so that specs in spec/requests still work.
    config.include Capybara::DSL, :type => :request
    config.include Capybara::RSpecMatchers, type: :request
    config.include RSpec::Core::DSL, type: :request
    # Disable the old-style object.should syntax.
    config.expect_with :rspec do |c|
      c.syntax = :expect
    end

    config.mock_with :rspec

    config.include FactoryGirl::Syntax::Methods

    config.include Rails.application.routes.url_helpers
    config.include RSpec::Rails::RequestExampleGroup, type: :request

    #config.include Devise::TestHelpers, :type => :controller
    #config.extend ControllerMacros, :type => :controller

    #config.treat_symbols_as_metadata_keys_with_true_values = true
    #config.filter_run focus: true
    #config.run_all_when_everything_filtered = true
    #config.filter_run_excluding :slow unless ENV['SLOW_SPECS']
    #config.fail_fast = true

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end
  end



  Capybara.configure do |config|
    config.match = :one
    config.exact_options = true
    config.ignore_hidden_elements = true
    config.visible_text_only = true
  end


  #Capybara.javascript_driver = :webkit
  Capybara.javascript_driver = :selenium
  #Capybara.server_port = 6543



end

Spork.each_run do
  MicroPost::Application.reload_routes!

end
