ActiveRecord::Base.connection.create_table(:addresses, force: true) do |t|
  t.timestamps
end

class Address < ActiveRecord::Base
  belongs_to :order_addresses
  has_many :orders, through: :order_addresses
end
