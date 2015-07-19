module Archetype
  module Attributes
    class AssociationBuilder < AttributeBuilder
      attr_accessor :nested

      def nests(*args, &block)
        opts = args.extract_options!
        builders = args.inject({}){|sum, a| sum[a] = AttributeBuilder.new(a); sum }
        self.nested = NestedBuilder.new(self, builders)
        nested.from_hash(opts).configure(&block)
      end

      def build(delegate)
        attribute = super
        attribute.nested = nested.build(delegate) if nested
        attribute
      end

      def default_class
        Association
      end
    end
  end
end
