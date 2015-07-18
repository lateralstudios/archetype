module Archetype
  module Attributes
    class Configuration
      attr_writer :attributes

      def attributes
        @attributes ||= []
      end
    end
  end
end
