# frozen_string_literal: true

RSpec.describe 'query methods' do
  shared_examples 'whereable scope queries' do
    it 'can query by scope' do
      address = Address.create!
      order = order_model.create!(address: address, total: 1)
      expect(order_model.by_address(address)).to eq([order])
      expect(order_model.where(address: address)).to eq([order])
    end

    it 'can query by scope and normal attributes' do
      address = Address.create!
      order1 = order_model.create!(address: address, total: 1)
      order2 = order_model.create!(address: address, total: 2)
      expect(order_model.where(address: address)).to eq([order1, order2])
      expect(order_model.where(address: address, total: 1)).to eq([order1])
      expect(order_model.where(address: address, total: 2)).to eq([order2])
    end

    it 'supports not query' do
      address1 = Address.create!
      address2 = Address.create!
      order1 = order_model.create!(address: address1)
      order2 = order_model.create!(address: address2)
      expect(order_model.where.not(address: address1)).to eq([order2])
    end

    it 'supports not query with normal attributes' do
      address1 = Address.create!
      address2 = Address.create!
      order1 = order_model.create!(address: address1, total: 1)
      order2 = order_model.create!(address: address2, total: 2)
      expect(order_model.where.not(address: address1, total: 1)).to eq([order2])
      expect(order_model.where.not(address: address1, total: 2)).to eq([])
    end

    it 'supports querying by array' do
      address1 = Address.create!
      address2 = Address.create!
      order1 = order_model.create!(address: address1)
      order2 = order_model.create!(address: address2)
      expect(order_model.where(address: [address1, address2])).to eq([order1, order2])
      expect(order_model.where.not(address: [address1, address2])).to eq([])
    end

    it 'supports unscope(:where)' do
      address1 = Address.create!
      address2 = Address.create!
      order1 = order_model.create!(address: address1)
      order2 = order_model.create!(address: address2)
      expect(order_model.where(address: address1).unscope(:where)).to eq([order1, order2])
    end

    # TODO
    xit 'supports unscope(where: ...)' do
      address1 = Address.create!
      address2 = Address.create!
      order1 = order_model.create!(address: address1)
      order2 = order_model.create!(address: address2)
      expect(order_model.where(address: address1).unscope(where: :address)).to eq([order1, order2])
    end

    # TODO
    xit 'supports rewhere' do
      address1 = Address.create!
      address2 = Address.create!
      order1 = order_model.create!(address: address1)
      order2 = order_model.create!(address: address2)
      expect(order_model.where(address: address1).rewhere(nil)).to eq([order1, order2])
      expect(order_model.where(address: address1).rewhere(address: address2)).to eq([order2])
    end
  end

  describe Order do
    let(:order_model) { Order }
    include_examples 'whereable scope queries'
  end

  describe SpecialOrder do
    let(:order_model) { SpecialOrder }
    include_examples 'whereable scope queries'
  end

  describe VerySpecialOrder do
    let(:order_model) { VerySpecialOrder }

    it 'has address scope overriden' do
      address = Address.create!
      order = order_model.create!(address: address, total: 1)
      expect(order_model.where(address: 1)).to eq([order])
    end

    it 'has newly defined total scope' do
      address = Address.create!
      order = order_model.create!(address: address, total: 1)
      expect(order_model.where(total: address)).to eq([order])
    end
  end
end
