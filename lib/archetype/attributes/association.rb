module Archetype
  module Attributes
    class Association < Attribute
      attr_accessor :nested

      def initialize(name, macro, options={})
        super(name, macro, options)
      end

      def association
        options[:association]
      end

      def nested
        @nested ||= NestedAttributes.new
      end

      def nested?
        nested.any?
      end

      def param
        return nested.params(name) if nested?
        super
      end

      private

      def default_presenter
        Presenters::AssociationPresenter
      end
    end
  end
end
