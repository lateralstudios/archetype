module Archetype
  module Interface
    class Configuration
      attr_reader :controller
      attr_accessor :navigation

      def initialize(controller)
        @controller = controller
      end

      def crumbs
        @crumbs ||= [home_crumb]
      end

      private

      def home_crumb
        Crumb.new(:home, :root)
      end

      module DSL
        def navigable(name, *args)
          opts = args.extract_options!
          path = args.first
          interface.navigation = Navigable.new(name, path, opts)
        end 

        def crumb(name, *args)
          opts = args.extract_options!
          path = args.first
          index = opts.delete(:position)
          crumb = Crumb.new(name, path, opts)
          if index
            interface.crumbs.insert(index, crumb)
          else
            interface.crumbs << crumb
          end
        end
      end
    end
  end
end
