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

      def type_class
        return klass = super if klass
        return Types::HasMany if %i(has_many_or_belongs_to).include?(type)
        return Types::HasOne if %i(belongs_to).include?(type)
      end

      def default_class
        Association
      end
    end
  end
end
