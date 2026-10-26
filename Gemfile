source 'https://rubygems.org'

gemspec

rails_version = ENV.fetch('RAILS_VERSION', '8.1')

gem 'rails', "~> #{rails_version}.0"

# Rails 8 apps default to Propshaft, older ones to Sprockets
if Gem::Version.new(rails_version) >= Gem::Version.new('8.0')
  gem 'propshaft'
else
  gem 'sprockets-rails'
end

gem 'rake', '~> 13.0'

group :development, :test do
  gem 'pry'
end

group :test do
  gem 'capybara'
  gem 'cuprite'
  gem 'puma'
  gem 'rspec-rails', '>= 6.1'
end
