source 'http://rubygems.org'

gem 'rails', '3.0.9'

gem 'sqlite3'
gem 'whenever'
gem 'devise'
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
gem 'permanent_records'

group :test do
  gem "factory_girl_rails"
  gem "autotest"
  gem "mocha"
  gem 'ruby-debug19', :require => 'ruby-debug'
end

group :development do
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'guard'
  gem "guard-bundler"
  gem "guard-rails"
  gem "guard-rspec"
  gem 'rb-fsevent', :require => false 
  gem "rb-inotify", :require => false
  gem "libnotify", :require => false
end

group :deploy do
  gem 'heroku'
end

gem "haml", ">= 3.0.0"
gem "haml-rails"
gem "rspec-rails", ">= 2.0.1", :group => [:development, :test]
