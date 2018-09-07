class RedisStorage
  def self.client
    @@client ||= Redis.new host: 'redis'
  end
end
