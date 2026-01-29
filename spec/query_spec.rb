# frozen_string_literal: true

RSpec.describe 'query methods' do
  let(:address) { Address.create! }

  it 'can query by scope' do
    order = Order.create!(address: address, total: 1)
    expect(Order.by_address(address)).to eq([order])
    expect(Order.where(address: address)).to eq([order])
  end

  it 'can query by scope and normal attributes' do
    order1 = Order.create!(address: address, total: 1)
    order2 = Order.create!(address: address, total: 2)
    expect(Order.where(address: address)).to eq([order1, order2])
    expect(Order.where(address: address, total: 1)).to eq([order1])
    expect(Order.where(address: address, total: 2)).to eq([order2])
  end

end
