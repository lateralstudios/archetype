module Archetype
  module Resourceful
    class Presenter
      attr_accessor :config, :controller

      def initialize(config, controller)
        @controller = controller
      end

      def resource
        return unless controller.respond_to?(:resource, true)
        @resource ||= ResourcePresenter.new(controller.send(:resource), self)
      end

      def collection
        controller.send(:collection)
      end
    end
  end
end
