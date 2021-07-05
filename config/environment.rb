# frozen_string_literal: true

require 'roda'
require 'figaro'
require 'logger'
require 'delegate'
require 'rack/cache'
require 'redis-rack-cache'

module CodePraise
  # Environment-specific configuration
  class Api < Roda
    plugin :environments

    # rubocop:disable Lint/ConstantDefinitionInBlock
    configure do
      # Environment variables setup
      Figaro.application = Figaro::Application.new(
        environment: environment,
        path: File.expand_path('config/secrets.yml')
      )
      Figaro.load
      def self.config() = Figaro.env

      # Logger setup
      LOGGER = Logger.new($stderr)
      def self.logger() = LOGGER
    end
    # rubocop:enable Lint/ConstantDefinitionInBlock

    configure :development, :test, :app_test do
      ENV['DATABASE_URL'] = "sqlite://#{config.DB_FILENAME}"
    end

    configure :development do
      use Rack::Cache,
          verbose: true,
          metastore: 'file:_cache/rack/meta',
          entitystore: 'file:_cache/rack/body'
    end

    configure :production do
      # Set DATABASE_URL environment variable on production platform
      puts 'RUNNING IN PRODUCTION MODE'

      use Rack::Cache,
          verbose: true,
          metastore: config.REDISCLOUD_URL + '/0/metastore',
          entitystore: config.REDISCLOUD_URL + '/0/entitystore'
    end

    configure :app_test do
      require_relative '../spec/helpers/vcr_helper'
      VcrHelper.setup_vcr
      VcrHelper.configure_vcr_for_github(recording: :none)
    end

    configure do
      require 'sequel'
      DB = Sequel.connect(ENV.delete('DATABASE_URL')) # rubocop:disable Lint/ConstantDefinitionInBlock
      # DB = Sequel.connect(ENV['DATABASE_URL']) # rubocop:disable Lint/ConstantDefinitionInBlock

      def self.DB # rubocop:disable Naming/MethodName
        DB
      end
    end
  end
end
