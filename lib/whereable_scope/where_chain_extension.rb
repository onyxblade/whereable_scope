module WhereableScope
  module WhereChainExtension
    include ScopeHandler

    def not(opts, *rest)
      case opts
      when Hash
        extract_whereable_scopes(opts, @scope.model) { |scope| @scope.merge!(scope.invert_where) }
        opts.empty? ? @scope : super
      else
        super
      end
    end
  end
end