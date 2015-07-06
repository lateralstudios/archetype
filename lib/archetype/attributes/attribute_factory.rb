module Archetype
  module Attributes
    class AttributeFactory
      attr_reader :attribute, :options, :old_attribute

      ATTRIBUTE_CLASSES = {
        uploader: Types::Uploader,
        belongs_to: Association
      }

      def initialize(options, attribute=nil)
        @options = options
        @old_attribute = attribute
        build
      end

      def name
        options[:name] || previous(:name)
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

      private

      def build
        @attribute = attribute_class.new(name, type, attribute_options)
      end

      def default_contexts
        return [] if %i(id created_at updated_at).include?(name.to_sym)
        contexts  = [:new, :edit, :show, :create, :update] 
        contexts += [:index] unless type == :text
        contexts
      end

      def filter_contexts(contexts, *args)
        return contexts unless args.any?
        filters = args.extract_options!
        return [] if args.include?(:none)
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
        Types.const_get(type.to_s.classify, false)
      rescue NameError
      end

      def default_class
        options[:association] ? Association : Attribute
      end
    end
  end
end
