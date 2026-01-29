module WhereableScope
  module QueryMethods
    def where!(opts, *rest)
      case opts
      when Hash
        whereable_scopes = model.whereable_scopes
        whereable_scopes.keys.each do |key|
          deleted = opts.delete(key.to_sym)
          if deleted
            new_scope = model.public_send(whereable_scopes[key], deleted)
            merge!(new_scope)
          end
        end
        if opts.empty?
          self
        else
          super
        end
      else
        super
      end
    end
  end
end
