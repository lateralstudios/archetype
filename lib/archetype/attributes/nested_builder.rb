module Archetype
  module Attributes
    class NestedBuilder < HashBuilder
      dsl_accessor :allow_destroy

      def initialize(parent, builders)
        @parent = parent
        super(builders)
      end

      def build(delegate)
        NestedAttributes.new(super, options)
      end

      def options
        {
          allow_destroy: allow_destroy?
        }
      end

      #TODO this is unused currently. Association.nested should be a NestedAttributes object
      def allow_destroy?
        !!@allow_destroy
      end

      def attributes(*args)
        opts = args.extract_options!
        args.each do |name|
          builder = self[name] || AttributeBuilder.new
          self[name] = builder.from_hash(opts.merge(name: name))
        end
      end
      alias_method :attribute, :attributes

      def association(*args)
        opts = args.extract_options!
        args.each do |name|
          builder = self[name] || AssociationBuilder.new
          self[name] = builder.from_hash(opts.merge(name: name))
        end
      end

      def attribute_model(model)
        builders = ModelFactory.new(model).build
        builders.each do |builder|
          self[builder.name] = builder
        end
      end
    end
  end
end
