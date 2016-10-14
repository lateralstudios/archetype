module Archetype
  module Attributes
    class AttributeBuilder < ModelBuilder
      DEFAULT_CONTEXTS = [:index, :show, :new, :edit, :create, :update, :destroy]

      dsl_accessor :type, :fieldset, :label, :contexts, :collection, :input, :position
      alias_method :context, :contexts

      def build_type
        @type || :string
      end

      def build_contexts
        @contexts || default_contexts
      end

      def build_input(value=NULL)
        @input || {}
      end

      def contexts=(value)
        @contexts = filter_contexts(contexts, value)
      end
      alias_method :context=, :contexts=

      def hidden?
        return true if %i(id created_at updated_at).include?(name)
        false
      end

      def attribute_options
        attribute_options = {}
        attribute_options[:fieldset] = fieldset if fieldset
        attribute_options[:label] = label if label
        attribute_options[:contexts] = contexts if contexts
        attribute_options[:position] = position if position
        attribute_options[:collection] = collection if collection
        attribute_options[:input] = input if input
        options.deep_merge(attribute_options)
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

      def self.for(type=nil)
        return self unless type.present?
        klass = self.descendants.find{|c| c.for_type?(type) }
        klass || self
      end

      def self.for_type?(type)
        name.demodulize == "#{type.to_s.classify}Builder"
      end
    end
  end
end
