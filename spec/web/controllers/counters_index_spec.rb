require 'spec_helper'
require_relative '../../../apps/web/controllers/index'

describe Web::Controllers::Counters::Index do
  let(:action) { Web::Controllers::Counters::Index.new }
  let(:params) { { text: 'test' } }
  let(:invalid_params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to be 200
  end

  it 'fails' do
    response = action.call(invalid_params)
    expect(response[0]).to be 404
  end
end