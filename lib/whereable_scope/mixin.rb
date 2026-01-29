module WhereableScope
  module Mixin
    def whereable_scope scope_name, as: nil
      as_value = as || scope_name
      whereable_scopes[as_value] = scope_name
    end

    def whereable_scopes
      if defined?(@whereable_scopes)
        @whereable_scopes
      else
        @whereable_scopes = {}
      end
    end
  end
end
