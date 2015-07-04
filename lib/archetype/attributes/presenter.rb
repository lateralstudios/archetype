module Archetype
  module Attributes
    class Presenter
      attr_accessor :controller

      def initialize(controller)
        @controller = controller
      end

      def for(context=nil)
        config.attributes.for(context).map(&:presenter)
      end
      alias_method :all, :for

      def fields(context=nil)
        self.for(context).map(&:field)
      end

      private

      def config
        controller.configuration.configs[:attributes]
      end
    end
  end
end
