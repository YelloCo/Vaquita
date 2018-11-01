source 'https://rubygems.org'

gem 'ansi-to-html'
gem 'autoprefixer-rails', '8.6.5' # 9.1.3 has a critical bug, so only bump after 9.1.4 comes out
gem 'bcrypt', '~> 3.1.7'
gem 'bulma-rails', '~> 0.7.0'
gem 'config'
gem 'devise'
gem 'devise_invitable', '~> 1.7.0'
gem 'ffi'
gem 'font-awesome-rails'
gem 'github_api'
gem 'gitlab'
gem 'jquery-rails'
gem 'pathspec'
gem 'puma'
gem 'rails', '~> 5.1.4'
gem 'redcarpet', '~> 3.4.0'
gem 'rufus-scheduler', '~> 3.4.2'
gem 'sass-rails', '~> 5.0'
gem 'sqlite3'
gem 'therubyracer', platforms: :ruby
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'brakeman', require: false
  gem 'byebug', platforms: %w[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'capybara-email', require: false
  gem 'chromedriver-helper', require: false
  gem 'eslintrb', require: false
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rubocop', require: false
  gem 'scss_lint', require: false
  gem 'selenium-webdriver'
  gem 'simplecov'
  gem 'sinatra', require: false
  gem 'sinatra-contrib', require: false
end

group :development do
  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-git-copy', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano3-puma', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 3.6'
  gem 'webmock'
end

group :production do
end

gem 'tzinfo-data', platforms: %w[mingw mswin x64_mingw jruby]
