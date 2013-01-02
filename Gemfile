source "http://rubygems.org"

gem "sinatra", "~> 1.3"
gem "haml"
gem 'unicorn'
gem 'pony'

group :development, :test do
  gem "rvm-capistrano"
  gem 'capistrano-unicorn', github: 'sosedoff/capistrano-unicorn', require: false
end

group :production do
  gem 'unicorn'
end