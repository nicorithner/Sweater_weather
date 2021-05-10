source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'jbuilder', '~> 2.7'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'faraday'
gem 'figaro'
gem 'jsonapi-serializer'

gem 'rack-cors'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'launchy'
  gem 'pry'
  gem 'rspec-rails'
  gem 'simplecov', require: false, group: :test
  gem 'shoulda-matchers'
  gem 'webmock'
  gem 'vcr'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'rubocop'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
