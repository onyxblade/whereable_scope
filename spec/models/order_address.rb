ActiveRecord::Base.connection.create_table(:order_addresses, force: true) do |t|
  t.belongs_to :order
  t.belongs_to :address
  t.timestamps
end

class OrderAddress < ActiveRecord::Base
  belongs_to :order
  belongs_to :address
end
