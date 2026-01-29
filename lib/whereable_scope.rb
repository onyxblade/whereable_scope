require 'active_record'
require 'active_record/relation'
require_relative './whereable_scope/version'
require_relative './whereable_scope/query_methods'
require_relative './whereable_scope/mixin'
require_relative './whereable_scope/where_chain_extension'

module WhereableScope
  ActiveRecord::Base.singleton_class.prepend WhereableScope::Mixin
  ActiveRecord::QueryMethods.prepend WhereableScope::QueryMethods
  ActiveRecord::QueryMethods::WhereChain.prepend WhereableScope::WhereChainExtension
end
