module Archetype
  module Resourceful
    class AttributeSet < SimpleDelegator
      attr_reader :attributes

      def initialize(attributes)
        @attributes = attributes
        super(attributes)
      end

      def for(context=nil)
        return self unless context.present?
        AttributeSet.new(with_context(context))
      end

      private

      def with_context(context)
        find_all{|a| a.contexts.include?(context) }
      end

      def self.from_model(model)
        new(discover_attributes(model))
      end

      def self.discover_attributes(model)
        model.columns.map{|c| Attribute.from_column(c) }
      end
    end
  end
end
