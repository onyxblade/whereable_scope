require_relative 'order'

class VerySpecialOrder < Order
  # It's so special that by_address queries by total, and by_total queries by address.
  scope :by_address, ->(total) { where(total: total) }
  scope :by_total, ->(address) { joins(:order_address).where(order_addresses: {address: address}) }
  whereable_scope :by_address, as: :address
  whereable_scope :by_total, as: :total
end