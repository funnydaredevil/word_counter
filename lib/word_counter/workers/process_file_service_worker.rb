require 'net/http'
require 'uri'

module WordCounter
  class ProcessFileServiceWorker
    include Sidekiq::Worker

    CHUNK_SIZE = 1024 * 1024

    def perform(identifier)
      fail 'File not found' unless identifier && File.exist?(identifier)
      File.open(identifier).each(nil, CHUNK_SIZE) do |chunk|
        chunk.split(/\W+/).map do |word|
          ::RedisStorage.client.incr(word.downcase)
        end
      end
    end
  end
end
