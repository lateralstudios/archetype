module Archetype
  module Dashboard
    class Presenter < Interface::ControllerPresenter
      def navigation
        @navigation ||= Interface::Navigation.new(build_navigation).ordered
      end

      private

      def build_navigation
        Archetype.controllers.map do |_, c|
          next unless c.module?(:interface) && c.module?(:resourceful)
          Navigable.new(c.interface.navigation, c.resource_class) if c.interface.navigation
        end.compact
      end
    end
  end
end
