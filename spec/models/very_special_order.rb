require_relative 'order'

class VerySpecialOrder < Order
  scope :by_total, ->(total) { where(total: total) }

  # It's so special that address queries by total, and total queries by address.
  whereable_scope :by_total, as: :address
  whereable_scope :by_address, as: :total
end