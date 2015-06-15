module Archetype
  module Base
    module Interface
      extend ActiveSupport::Concern

      included do
        layout 'archetype/application'
        helper_method :main_navigation
      end

      def main_navigation
        Archetype.interface.navigation
      end

      module ClassMethods
        def navigable(name, *args)
          opts = args.extract_options!
          path = args.first
          Archetype.interface.navigable(name, path, opts)
        end 
      end

    end
  end
end
