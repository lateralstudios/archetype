module Archetype
  module Base
    module Interface
      extend ActiveSupport::Concern

      included do
        layout 'archetype/application'
        helper_method :interface, :page
      end

      def page
        @page ||= interface.page_for(self)
      end

      def interface
        Archetype.interface
      end

      module ClassMethods
        def navigable(name, *args)
          opts = args.extract_options!
          path = args.first
          Archetype.interface.navigation.add_parent(name, path, opts)
        end 
      end

    end
  end
end
