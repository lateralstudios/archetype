module Archetype
  module Attributes
    class AttributeSet < SimpleDelegator
      def initialize(attributes=[])
        super(attributes)
      end

      def [](name)
        find(name).first
      end

      def only(*names)
        self.class.new(with_names(names.flatten))
      end

      def for(context=nil)
        return self unless context.present?
        self.class.new(with_context(context))
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
