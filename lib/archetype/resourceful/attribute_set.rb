module Archetype
  module Resourceful
    class AttributeSet < SimpleDelegator
      attr_reader :attributes

      def initialize(attributes)
        @attributes = attributes
        super(attributes)
      end

      def find(names)
        AttributeSet.new(with_names(names))
      end

      def for(context=nil)
        return self unless context.present?
        AttributeSet.new(with_context(context))
      end

      def update(params)
        attributes.each{|a| a.update(params) }
      end

      private

      def with_names(names)
        find_all{|a| names.include?(a.name) }
      end
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
