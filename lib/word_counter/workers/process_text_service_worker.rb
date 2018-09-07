module WordCounter
  class ProcessTextServiceWorker
    include Sidekiq::Worker

    def perform(identifier)
      identifier.split(/\W+/).map do |word|
        ::RedisStorage.client.incr(word.downcase)
      end
    end
  end
end
