module Archetype
  module Dashboard
    class Navigable < DelegateClass(Interface::Navigable)
      attr_reader :resource_class

      def initialize(navigable, resource_class=nil)
        super(navigable)
        @resource_class = resource_class
      end

      def count
        return unless resource_class
        resource_class.count
      end
    end
  end
end
