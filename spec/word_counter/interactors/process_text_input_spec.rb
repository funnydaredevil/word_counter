require 'spec_helper'

RSpec.describe ProcessTextInput, type: :interactor do
  describe '#call' do

    context 'when success with ::WordCounter::ProcessTextServiceWorker' do
      let(:interactor) { described_class.new(service_worker: ::WordCounter::ProcessTextServiceWorker) }
      let(:call) { interactor.call('test') }

      it { expect(call).to be_a_success }
    end

    context 'when success with ::WordCounter::ProcessUrlServiceWorker' do
      let(:interactor) { described_class.new(service_worker: ::WordCounter::ProcessUrlServiceWorker) }
      let(:call) { interactor.call('test') }

      it { expect(call).to be_a_success }
    end

    context 'when success with ::WordCounter::ProcessFileServiceWorker' do
      let(:interactor) { described_class.new(service_worker: ::WordCounter::ProcessFileServiceWorker) }
      let(:call) { interactor.call('test') }

      it { expect(call).to be_a_success }
    end

  end
end
