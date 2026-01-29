# frozen_string_literal: true

RSpec.describe 'ActiveRecord::Base mixin' do
  it 'sets whereable_scopes' do
    expect(Order.whereable_scopes).to eq({address: :by_address})
  end

end
