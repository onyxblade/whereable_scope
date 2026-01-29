require_relative './lib/whereable_scope/version'

Gem::Specification.new do |spec|
  spec.name          = 'whereable_scope'
  spec.version       = WhereableScope::VERSION
  spec.authors       = ['merely']
  spec.email         = ['git@merely.ca']
  spec.homepage      = 'https://github.com/onyxblade/whereable_scope'
  spec.summary       = 'Use ActiveRecord scopes as parameters in where clauses'
  spec.description   = ''
  spec.license       = 'MIT'

  spec.files         = Dir.glob("lib/**/*.rb")

  spec.add_runtime_dependency 'activerecord', '>= 7.2', '< 8.1'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'database_cleaner-active_record'
  spec.add_development_dependency 'rake'
end
