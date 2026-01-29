module WhereableScope
  module WhereChainExtension
    def not(opts, *rest)
      case opts
      when Hash
        whereable_scopes = @scope.model.whereable_scopes
        whereable_scopes.keys.each do |key|
          deleted = opts.delete(key.to_sym)
          if deleted
            new_scope = @scope.model.public_send(whereable_scopes[key], deleted)
            @scope.merge!(new_scope.invert_where)
          end
        end
        if opts.empty?
          @scope
        else
          super
        end
      else
        super
      end
    end
  end
end