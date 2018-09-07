require 'hanami/interactor'
# require './lib/word_counter/workers/process_text_service_worker'

class ProcessTextInput
  include Hanami::Interactor

  def initialize(service_worker: ::WordCounter::ProcessTextServiceWorker)
    @service_worker = service_worker
  end

  def call(identifier)
    @service_worker.perform_async(identifier)
  end
end