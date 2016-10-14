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

      def default_fieldset
        fieldsets[0]
      end
    end
  end
end
