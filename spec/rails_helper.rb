require 'spec_helper'

ENV['RAILS_ENV'] = 'test'
require_relative 'dummy/config/environment'

require 'rspec/rails'
require 'capybara/cuprite'

Capybara.server = :puma, { Silent: true }

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :cuprite, options: { headless: true, js_errors: true }
  end
end
