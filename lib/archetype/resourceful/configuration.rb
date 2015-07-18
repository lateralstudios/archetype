module Archetype
  module Resourceful
    class Configuration
      attr_writer :actions, :per_page

      def actions
        @actions ||= default_actions
      end

      def per_page
        @per_page ||= 25
      end
    end
  end
end
