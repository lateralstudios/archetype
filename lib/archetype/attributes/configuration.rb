module Archetype
  module Attributes
    class Configuration
      attr_writer :attributes, :fieldsets

      def attributes
        @attributes ||= []
      end

      def fieldsets
        @fieldsets ||= []
      end
    end
  end
end
