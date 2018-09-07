require 'hanami/interactor'

class WordOccurences
  include Hanami::Interactor

  expose :count

  def call(process_text_attributes)
    fail unless process_text_attributes[:text]
    @count = RedisStorage.client.get(process_text_attributes[:text].downcase) || 0
  end
end