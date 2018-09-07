require 'net/http'
require 'uri'

module WordCounter
  class ProcessUrlServiceWorker
    include Sidekiq::Worker

    def perform(identifier)
      text = Net::HTTP.get(URI.parse(identifier))
      text.split(/\W+/).map do |word|
        ::RedisStorage.client.incr(word.downcase)
      end
    end
  end
end
