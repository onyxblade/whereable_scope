module WhereableScope
  module ScopeHandler
    # Extracts whereable scope parameters from opts hash and applies them.
    # Yields each resolved scope to the block for custom handling.
    #
    # @param opts [Hash] the options hash to extract from (mutated)
    # @param model [Class] the ActiveRecord model class
    # @yield [scope] yields each resolved scope for custom merge logic
    def extract_whereable_scopes(opts, model)
      model.whereable_scopes.each do |key, scope_name|
        value = opts.delete(key.to_sym)
        if value
          yield model.public_send(scope_name, value)
        end
      end
    end
  end
end
