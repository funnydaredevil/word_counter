module Web::Controllers::Counters
  class Index
    include Web::Action
    accept :json

    expose :counters, :error
    
    params do
      required(:text).filled(:str?)
    end

    def call(params)
      if params.valid? && word_occurences.success?
        self.body = { counters: word_occurences.count }.to_json
      else
        self.status = 404
        self.body = { error: 'Invalid params' }.to_json
      end
    end

    private

    def word_occurences
      @process_text_input ||= ::WordOccurences.new.call(params)
    end
  end
end