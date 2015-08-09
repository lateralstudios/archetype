module Archetype
  module Attributes
    class AttributeSet < SimpleDelegator
      def initialize(attributes=[])
        super(attributes)
      end

      def [](name)
        find{|a| a.name == name }
      end

      def only(*names)
        self.class.new(with_names(names.flatten))
      end

      def for(context)
        self.class.new(with_context(context))
      end

      def any_context
        self.class.new(find_all{|a| a.contexts.any? })
      end

      def for_fieldset(name)
        self.class.new(find_all{|a| a.fieldset == name })
      end

      private

      def with_names(names)
        find_all{|a| names.include?(a.name) }
      end

      def with_context(context)
        find_all{|a| a.contexts.include?(context) }
      end
    end
  end
end
