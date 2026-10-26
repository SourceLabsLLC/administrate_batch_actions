require 'spec_helper'

ENV['RAILS_ENV'] = 'test'
require_relative 'dummy/config/environment'

require 'rspec/rails'
require 'capybara/cuprite'

Capybara.server = :puma, { Silent: true }

RSpec.configure do |config|
  config.before(:each, type: :system) do
    # Chrome can be slow to start on a cold CI runner
    driven_by :cuprite, options: {
      headless: true,
      js_errors: true,
      process_timeout: 30,
      browser_options: ENV['CI'] ? { 'no-sandbox' => nil } : {}
    }
  end
end
