module WhereableScope
  module QueryMethods
    include ScopeHandler

    def where!(opts, *rest)
      case opts
      when Hash
        extract_whereable_scopes(opts, model) { |scope| merge!(scope) }
        opts.empty? ? self : super
      else
        super
      end
    end
  end
end
