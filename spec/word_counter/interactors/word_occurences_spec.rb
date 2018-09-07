require 'spec_helper'

RSpec.describe WordOccurences, type: :interactor do
  describe '#call' do
    let(:interactor) { described_class.new }
    let(:call) { interactor.call(text: 'test') }

    context 'when success' do
      let(:occurences) { 10 }

      before do
        allow(RedisStorage).to receive_message_chain(:client, :get).and_return(occurences)
      end
      
      it { expect(call).to be_a_success }
      it 'has 10 occurences' do
        expect(call.count).to be occurences
      end
    end

    context 'when success with no results' do
      let(:occurences) { 0 }

      before do
        allow(RedisStorage).to receive_message_chain(:client, :get).and_return(occurences)
      end
      
      it { expect(call).to be_a_success }
      it 'has no occurences' do
        expect(call.count).to be 0
      end
    end

    context 'when failure' do
      let(:call) { interactor.call(invalid_attr: 'test') }
      
      it { expect { call }.to raise_error(RuntimeError) }
    end
  end
end
