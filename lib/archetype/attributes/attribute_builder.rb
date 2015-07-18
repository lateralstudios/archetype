module Archetype
  module Attributes
    class AttributeBuilder < ObjectBuilder
      attr_reader :name

      DEFAULT_CONTEXTS = [:index, :show, :new, :edit, :create, :update, :destroy]

      dsl_accessor :name, :type, :label, :contexts, :collection, :input, :position, :options
      alias_method :context, :contexts
      alias_method :context=, :contexts=

      def initialize(name, options={})
        @name = name
        @options = process_options(options || {})
      end

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

      def contexts=(value)
        @contexts = filter_contexts(contexts, value)
      end

      def hidden?
        return true if %i(id created_at updated_at).include?(name)
        return true if type == :has_many
        false
      end

      def dsl_method
        super || name.to_sym
      end

      def attribute_options
        options.merge({
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

      def process_options(opts)
        opts.inject({}) do |sum, (k, v)|
          if respond_to?("#{k}=")
            send("#{k}=", v)
          else
            sum[k] = v
          end
          sum
        end
      end

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
        class_name = type.to_s.classify
        klass = ["Archetype::#{class_name}", "Archetype::Attributes::Types::#{class_name}"].find do |const|
          try_constant const
        end
        klass.constantize if klass
      end

      def default_class
        options[:association] ? Association : Attribute
      end

      def try_constant(const)
        const.constantize
      rescue NameError
      end
    end
  end
end
