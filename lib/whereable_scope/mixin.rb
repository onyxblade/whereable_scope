module WhereableScope
  module Mixin
    def whereable_scope scope_name, as: nil
      as_value = as || scope_name
      own_whereable_scopes[as_value] = scope_name
    end

    def whereable_scopes
      if superclass.respond_to?(:whereable_scopes)
        superclass.whereable_scopes.merge(own_whereable_scopes)
      else
        own_whereable_scopes
      end
    end

    def own_whereable_scopes
      @whereable_scopes ||= {}
    end
  end
end
