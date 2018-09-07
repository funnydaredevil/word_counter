require 'bundler/setup'
require 'hanami/setup'
require_relative '../lib/word_counter'
require_relative '../apps/web/application'
require_relative './sidekiq'
require_relative './redis'

Hanami.configure do
  mount Web::Application, at: '/'
  environment :development do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :debug
  end

  environment :production do
    logger level: :info, formatter: :json, filter: []
  end
end
