module Archetype
  module Attributes
    class AttributeFactory
      attr_reader :attribute, :options, :old_attribute

      DEFAULT_CONTEXTS = [:index, :show, :new, :edit, :create, :update, :destroy]

      def initialize(options, attribute=nil)
        @options = options
        @old_attribute = attribute
        build
      end

      def name
        (options[:name] || previous(:name)).to_sym
      end
      
      def type
        options[:type] || previous(:type) || :string
      end

      def options
        options = previous(:options) || {}
        options.merge(@options)
      end

      def contexts
        contexts = previous(:contexts) || default_contexts
        context_options = options[:contexts] || options[:context]
        filter_contexts(contexts, context_options)
      end

      def attribute_options
        options.merge({
          contexts: contexts
        })
      end

      def previous(attr)
        old_attribute ? old_attribute.send(attr) : nil
      end

      def hidden?
        return true if %i(id created_at updated_at).include?(name)
        return true if type == :has_many
        false
      end

      private

      def build
        @attribute = attribute_class.new(name, type, attribute_options)
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
