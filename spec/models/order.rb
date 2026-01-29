ActiveRecord::Base.connection.create_table(:orders, force: true) do |t|
  t.integer :total
  t.timestamps
end

class Order < ActiveRecord::Base
  has_one :order_address
  has_one :address, through: :order_address

  scope :by_address, -> (address) { joins(:order_address).where(order_addresses: {address: address}) }
  whereable_scope :by_address, as: :address
end
