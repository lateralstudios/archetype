module Archetype
  module Attributes
    class NestedBuilder < HashBuilder
      dsl_accessor :allow_destroy

      def initialize(parent, builders)
        @parent = parent
        super(builders)
      end

      #TODO this is unused currently. Association.nested should be a NestedAttributes object
      def allow_destroy?
        !!@allow_destroy
      end

      def attributes(*args)
        opts = args.extract_options!
        args.each do |name|
          builder = self[name] || AttributeBuilder.new(name)
          self[name] = builder.from_hash(opts)
        end
      end
      alias_method :attribute, :attributes

      def association(*args)
        opts = args.extract_options!
        args.each do |name|
          builder = self[name] || AssociationBuilder.new(name)
          self[name] = builder.from_hash(opts)
        end
      end
    end
  end
end
