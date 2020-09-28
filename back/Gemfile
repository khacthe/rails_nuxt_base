source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git"}

ruby "2.6.6"

gem "active_model_serializers"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", ">= 1.4.2", require: false
gem "config"
gem "figaro"
gem "jbuilder", "~> 2.7"
gem "jwt"
gem "kaminari"
gem "mysql2", ">= 0.4.4"
gem "paranoia"
gem "puma", "~> 4.1"
gem "rack-attack"
gem "rack-cors"
gem "ransack"
gem "rails", "~> 6.0.3", ">= 6.0.3.3"
gem "redis", "~> 4.0"
gem "sidekiq"
gem "swagger-blocks"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "pry"
  gem "pry-byebug"
  gem "rubocop-rails", require: false
end

group :development do
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console"
end

group :test do
  gem "shoulda-matchers"
  gem "rspec-rails"
  gem "database_cleaner"
  gem "timecop"
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
