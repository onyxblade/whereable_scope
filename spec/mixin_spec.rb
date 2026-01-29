# frozen_string_literal: true

RSpec.describe 'ActiveRecord::Base mixin' do
  it 'sets whereable_scopes' do
    expect(Order.whereable_scopes).to eq({address: :by_address})
  end

  it 'sets whereable_scopes for inherited models' do
    expect(SpecialOrder.whereable_scopes).to eq({address: :by_address})
  end

  it 'can override whereable_scopes from parent model' do
    expect(VerySpecialOrder.whereable_scopes).to eq({address: :by_address, total: :by_total})
  end

end
