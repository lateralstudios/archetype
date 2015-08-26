module Archetype
  module Attributes
    class AttributeBuilder < ModelBuilder
      DEFAULT_CONTEXTS = [:index, :show, :new, :edit, :create, :update, :destroy]

      dsl_accessor :type, :fieldset, :label, :contexts, :collection, :input, :position

      def type(value=NULL)
        type = @type || :string
        return type if value == NULL
        self.type = value
      end

      def contexts(value=NULL)
        contexts = @contexts || default_contexts
        return contexts if value == NULL
        self.contexts = value
      end

      # TODO: This is wrong - we shouldn't override the setters like this.
      def contexts=(value)
        @contexts = filter_contexts(contexts, value)
      end
      alias_method :context, :contexts
      alias_method :context=, :contexts=

      def hidden?
        return true if %i(id created_at updated_at).include?(name)
        false
      end

      def attribute_options
        options.merge({
          fieldset: fieldset,
          label: label,
          contexts: contexts,
          position: position,
          collection: collection,
          input: input
        }.compact)
      end

      def build(delegate)
        super
        attribute_class.new(name, type, attribute_options)
      end

      private

      def default_contexts
        return [] if hidden?
        contexts  = DEFAULT_CONTEXTS.clone
        contexts.delete(:index) if type == :text
        contexts
      end

      def filter_contexts(contexts, *args)
        return contexts unless args.any?
        filters = args.extract_options!
        return [] if args.include?(:none)
        contexts = DEFAULT_CONTEXTS if args.delete(:all)
        contexts = args if args.any?
        contexts = (contexts - Array.wrap(filters[:except])) if filters[:except]
        contexts = (contexts + Array.wrap(filters[:on])).uniq if filters[:on]
        contexts.flatten
      end

      def attribute_class
        return options[:class] if options.key?(:class)
        type_class || default_class
      end

      def type_class
        default_class.descendants.find{|c| c.for_type?(type) }
      end

      def default_class
        Attribute
      end
    end
  end
end
