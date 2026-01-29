# WhereableScope

A Ruby gem that enhances ActiveRecord's `where` method to support calling scopes directly through the where clause.

## Motivation

Consider an `Order` model that originally had an `address_id` column:

```ruby
# This worked when address_id was a column on orders
Order.where(address: address)
```

After migrating to a separate `order_addresses` join table, the associations become:

```ruby
class Order < ActiveRecord::Base
  has_one :order_address
  has_one :address, through: :order_address
end
```

Now the old `where(address: ...)` syntax no longer works - potentially breaking many existing queries throughout your codebase.

With WhereableScope, you can preserve the original query interface by mapping a scope to the `address` parameter:

```ruby
class Order < ActiveRecord::Base
  has_one :order_address
  has_one :address, through: :order_address

  scope :by_address, ->(address) { joins(:order_address).where(order_addresses: { address: address }) }

  whereable_scope :by_address, as: :address
end

# This continues to work after the migration!
Order.where(address: address)
```

## Installation

Add this line to your application's Gemfile and `bundle install`:

```ruby
gem 'whereable_scope'
```

## Usage

Register a scope with `whereable_scope`:

```ruby
whereable_scope :by_address, as: :address
```

This takes:
- The scope name (e.g., `:by_address`)
- An `as:` option to define the parameter name used in `where` (e.g., `as: :address`)

Once registered, you can use it in `where`:

```ruby
# These are now equivalent:
Order.by_address(address)
Order.where(address: address)

# Combine with other conditions:
Order.where(address: address, total: 100)
```

## Limitations

`unscope(:where)` or `unscope(where: :address)` will not revert the merged scope. Since the scope is applied via `merge`, the resulting query conditions are not tracked under the `where` parameter name.

## Development

After checking out the repo:

```bash
# Install dependencies
bundle install

# Run tests
bundle exec rake
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
