source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 2.7.1'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.0.2'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~> 2.5.3'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.2.6'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.9'

# Load enviroment variables
gem 'dotenv-rails', '~> 2.0.1'

# CSS framework
gem 'bootstrap-sass', '~> 3.3.1'
# Select extension
gem 'bootstrap-select-rails', '~> 1.6.3'
# Pretty dialogs
gem 'bootbox-rails', '~> 0.4.0'

# Icons
gem 'font-awesome-rails', '~> 4.3.0'

# Markdown parser
gem 'redcarpet', '~> 3.2.2'

# Pagination gem
gem 'kaminari', '~> 0.16.1'

# Use haml for views
gem 'haml-rails', '~> 0.9.0'

# Webserver
gem 'puma', '~> 2.11.1'

# Search
gem 'pg_search', '~> 1.0.0'

# Charts
gem 'chartkick', '~> 1.3.2'
gem 'groupdate', '~> 2.4.0'

group :production do
  gem 'pg', '~> 0.18.1'
  gem 'rails_12factor', '~> 0.0.3'
end

group :development do
  gem 'rails_layout', '~> 1.0.24'
  gem 'byebug', '~> 4.0.5'
  # better error messages
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', '~> 0.7.2'
  gem 'rack-mini-profiler', '~> 0.9.2'
end

group :test do
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'capybara', '~> 2.4.4'
  gem 'launchy', '~> 2.4.3'
  # Stubs and mocks for testing
  gem 'rspec-activemodel-mocks', '~> 1.0.1'
  # Matchers for common Rails functionality
  gem 'shoulda-matchers', '~> 2.8.0', require: false
  gem 'simplecov', '~> 0.9.1', require: false
  gem 'coveralls', '~> 0.8.0', require: false
  gem 'rubocop', '~> 0.30.0'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.2.1'
  gem 'sqlite3', '~> 1.3.10'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.1', require: false
end
