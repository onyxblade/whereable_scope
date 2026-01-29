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

  it 'supports not query' do
    address1 = Address.create!
    address2 = Address.create!
    order1 = Order.create!(address: address1)
    order2 = Order.create!(address: address2)
    expect(Order.where.not(address: address1)).to eq([order2])
  end

  it 'supports not query with normal attributes' do
    address1 = Address.create!
    address2 = Address.create!
    order1 = Order.create!(address: address1, total: 1)
    order2 = Order.create!(address: address2, total: 2)
    expect(Order.where.not(address: address1, total: 1)).to eq([order2])
    expect(Order.where.not(address: address1, total: 2)).to eq([])
  end

  it 'supports querying by array' do
    address1 = Address.create!
    address2 = Address.create!
    order1 = Order.create!(address: address1)
    order2 = Order.create!(address: address2)
    expect(Order.where(address: [address1, address2])).to eq([order1, order2])
    expect(Order.where.not(address: [address1, address2])).to eq([])
  end

  it 'supports unscope(:where)' do
    address1 = Address.create!
    address2 = Address.create!
    order1 = Order.create!(address: address1)
    order2 = Order.create!(address: address2)
    expect(Order.where(address: address1).unscope(:where)).to eq([order1, order2])
  end

  # TODO
  xit 'supports unscope(where: ...)' do
    address1 = Address.create!
    address2 = Address.create!
    order1 = Order.create!(address: address1)
    order2 = Order.create!(address: address2)
    expect(Order.where(address: address1).unscope(where: :address)).to eq([order1, order2])
  end

  # TODO
  xit 'supports rewhere' do
    address1 = Address.create!
    address2 = Address.create!
    order1 = Order.create!(address: address1)
    order2 = Order.create!(address: address2)
    expect(Order.where(address: address1).rewhere(nil)).to eq([order1, order2])
    expect(Order.where(address: address1).rewhere(address: address2)).to eq([order2])
  end

end
