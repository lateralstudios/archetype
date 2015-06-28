module Archetype
  module Resourceful
    module Attributes
      class SimpleFormInput < DelegateClass(Archetype::Resourceful::Attributes::Attribute)
        def input_options
          opts = {}
          user_opts = options[:input] || {}
          opts[:as] = type
          collection = options[:collection] || user_opts[:collection]
          if collection
            opts[:as] = :select
            opts[:collection] = collection
          end
          opts.merge!(user_opts)
        end
      end
    end
  end
end
