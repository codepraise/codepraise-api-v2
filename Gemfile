# frozen_string_literal: true

source 'https://rubygems.org'
ruby File.read('.ruby-version').strip

# PRESENTATION LAYER
gem 'multi_json'
gem 'roar'

# APPLICATION LAYER
# Web application related
gem 'figaro'
gem 'puma'
gem 'rack' # 2.3 will fix delegateclass bug
gem 'roda'

# Controllers and services
gem 'dry-monads'
gem 'dry-transaction'
gem 'dry-validation'

# Caching
gem 'rack-cache'
gem 'redis'
gem 'redis-rack-cache'

# DOMAIN LAYER
# Validation
gem 'dry-struct'
gem 'dry-types'

# INFRASTRUCTURE LAYER
# Networking
gem 'http'

# Asynchronicity
gem 'aws-sdk-sqs'
gem 'concurrent-ruby'

# Database
gem 'hirb'
gem 'sequel'

group :development, :test do
  gem 'database_cleaner'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end

# WORKERS
gem 'faye'
gem 'shoryuken'

# TESTING
group :test do
  gem 'minitest'
  gem 'minitest-rg'

  gem 'simplecov'
  gem 'vcr'
  gem 'webmock'
end

group :development, :test do
  gem 'rerun'
end

# DEBUGGING
group :development do
  # Debugging: see https://stackify.com/ruby-debugger-using-visual-studio-code/
  gem 'debase'
  gem 'ruby-debug-ide'
end

# QUALITY
group :development, :test do
  gem 'flog'
  gem 'reek'
  gem 'rubocop'
end

# UTILITIES
gem 'rack-test' # can also be used to diagnose production
gem 'rake'
