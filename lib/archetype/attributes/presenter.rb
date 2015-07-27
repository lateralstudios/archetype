module Archetype
  module Attributes
    class Presenter
      attr_accessor :config, :controller
      delegate :[], to: :attributes

      def initialize(config, controller)
        @config = config
        @controller = controller
      end

      def for(context=nil)
        attributes.for(context)
      end
      alias_method :all, :for

      def fields(context, form, object)
        attributes = self.for(context)
        attributes.map{|a| a.field(form, object) }
      end

      private

      def attributes
        @attributes ||= AttributeSet.new(config.attributes.map{|a| a.presenter_class.new(a, h) })
      end

      def h
        controller.view_context
      end
    end
  end
end
