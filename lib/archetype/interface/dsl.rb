module Archetype
  module Interface
    module DSL
      attr_reader :navigation

      def navigable(name, *args)
        opts = args.extract_options!
        path = args.first
        @navigation = Navigable.new(name, path, opts)
      end 
    end
  end
end
