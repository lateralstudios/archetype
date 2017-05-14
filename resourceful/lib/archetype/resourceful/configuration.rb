module Archetype
  module Resourceful
    class Configuration
      attr_accessor :actions, :per_page
      attr_writer :scopes

      def scopes
        @scopes ||= {}
      end
    end
  end
end
