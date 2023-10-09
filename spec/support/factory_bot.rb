require 'factory_bot'
RSpec.configure do |config|
  # we can write below line in rails_helper.rb
  config.include FactoryBot::Syntax::Methods
end
