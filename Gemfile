source 'https://rubygems.org'
if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

gem 'rails', '3.2.13'
gem 'jquery-rails'
gem 'rake'
gem 'pg'
gem 'unicorn'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'cancan'
gem 'paperclip', '~> 3.0'
gem 'simple_form'
gem 'font-awesome-rails'
gem 'aws-sdk'
gem 'friendly_id'
gem 'kaminari'
gem 'stripe'
gem 'figaro'
gem 'twilio-ruby'
gem 'haml-rails'
gem "rolify",        :git => "git://github.com/EppO/rolify.git"


group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass', '~> 2.3.1.0'
end

group :development, :test do
  gem "shoulda-matchers"
  gem "shoulda-context"
  gem 'rspec-rails'
  gem 'unicorn'
  gem 'heroku'
  gem 'pry'
  gem 'simplecov'
  gem 'factory_girl_rails'
  gem 'cane'
  gem 'reek'
  gem 'erb2haml'
  gem 'html2haml'
  gem 'pry-remote'
  gem 'letter_opener'
  gem 'guard-rspec'
end

group :test do 
  gem 'database_cleaner'
  gem 'launchy'
  gem 'capybara'
  gem 'faker'
end

group :development do 
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rails-footnotes', '>= 3.7.9'
  # gem 'meta_request'
end


