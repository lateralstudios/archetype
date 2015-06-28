module Archetype
  module Resourceful
    class AttributeSet < SimpleDelegator
      attr_reader :attributes

      def initialize(attributes)
        @attributes = attributes
        super(attributes)
      end

      def new(name, opts={})
        attribute = Attribute.new(name, opts.delete(:type), opts)
        @attributes << attribute
        attribute
      end

      def [](name)
        find(name).first
      end

      def find(*names)
        self.class.new(with_names(names.flatten))
      end

      def for(context=nil)
        return self unless context.present?
        self.class.new(with_context(context))
      end

      def update(params)
        attributes.each{|a| a.update(params) }
      end

      private

      def with_names(names)
        return attributes if names.include?(:all)
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
