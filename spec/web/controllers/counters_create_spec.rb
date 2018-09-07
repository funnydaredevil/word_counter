require 'spec_helper'
require_relative '../../../apps/web/controllers/create'

describe Web::Controllers::Counters::Create do
  let(:action) { Web::Controllers::Counters::Create.new }
  let(:text_params) { { text: 'test' } }
  let(:url_params) { { url: 'test' } }
  let(:file_params) { { server_file: 'test' } }
  let(:invalid_params) { Hash[] }

  it 'is successful with text param' do
    response = action.call(text_params)
    expect(response[0]).to be 201
  end

  it 'is successful with url param' do
    response = action.call(url_params)
    expect(response[0]).to be 201
  end

  it 'is successful with file param' do
    response = action.call(file_params)
    expect(response[0]).to be 201
  end

  it 'fails' do
    response = action.call(invalid_params)
    expect(response[0]).to be 422
  end
end