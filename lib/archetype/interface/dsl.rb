module Archetype
  module Interface
    module DSL
      attr_reader :_navigation

      def navigable(name, *args)
        opts = args.extract_options!
        path = args.first
        @_navigation = Navigable.new(name, path, opts)
      end 

      def crumb(name, *args)
        opts = args.extract_options!
        path = args.first
        index = opts.delete(:position)
        crumb = Crumb.new(name, path, opts)
        if index
          _crumbs.insert(index, crumb)
        else
          _crumbs << crumb
        end
      end

      def _crumbs
        @_crumbs ||= [home_crumb]
      end

      private

      def home_crumb
        Crumb.new(:home, :root)
      end
    end
  end
end
