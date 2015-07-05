module Archetype
  module Attributes
    class Presenter
      attr_accessor :controller

      def initialize(controller, view_context)
        @controller = controller
        @view_context = view_context
      end

      def for(context=nil)
        attributes.for(context).map{|a| a.presenter_class.new(a, h) }
      end
      alias_method :all, :for

      def fields(context=nil)
        self.for(context).map(&:field)
      end

      private

      def attributes
        @attributes ||= AttributeSet.new(config.attributes)
      end

      def config
        controller.configuration.configs[:attributes]
      end

      def h
        @view_context
      end
    end
  end
end
