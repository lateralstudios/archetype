module Archetype
  module Resourceful
    module Attributes
      class SimpleFormInput < DelegateClass(Archetype::Resourceful::Attributes::Attribute)
        def input_options
          opts = {}
          input_opts = options[:input] || {}
          opts[:as] = input_opts[:as]
          collection = options[:collection] || input_opts[:collection]
          opts[:collection] = options[:collection]
          opts.merge!(input_opts)
        end
      end
    end
  end
end
