module Web::Controllers::Counters
  class Create
    include Web::Action

    params do
      optional(:text).filled(:str?)
      optional(:server_file).filled(:str?)
      optional(:url).filled(:str?)
    end

    def call(params)
      if params.valid? && params_present? && process_text_input.success?
        self.status = 201
      else
        self.status = 422
      end
    end

    private

    def params_present?
      params[:text] || params[:server_file] || params[:url]
    end

    def process_text_input
      @process_text_input ||= ::ProcessTextInput.new(service_worker: service_worker)
      @process_text_input.call(service_worker_attributes)
    end

    def service_worker
      {
        text: ::WordCounter::ProcessTextServiceWorker,
        url: ::WordCounter::ProcessUrlServiceWorker,
        server_file: ::WordCounter::ProcessFileServiceWorker
      }[params_criteria]
    end

    def params_criteria
      params.to_h&.first&.first || :text
    end

    def service_worker_attributes
      params.to_h&.first&.last
    end
  end
end
