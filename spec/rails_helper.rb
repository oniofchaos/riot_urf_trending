ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.infer_spec_type_from_file_location!
  config.raise_errors_for_deprecations!
end
