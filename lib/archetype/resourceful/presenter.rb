module Archetype
  module Resourceful
    class Presenter
      attr_accessor :controller

      def initialize(controller)
        @controller = controller
      end

      def resource
        return unless controller.respond_to?(:resource, true)
        @resource ||= ResourcePresenter.new(controller.send(:resource), self)
      end

      def collection
        controller.send(:collection)
      end

      private

      def config
        controller.configuration.resourceful
      end
    end
  end
end
