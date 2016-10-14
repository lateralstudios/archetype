module Archetype
  module Interface
    class ControllerPresenter
      attr_accessor :controller

      def initialize(controller)
        @controller = controller
      end

      def title
        controller_title
      end

      def name_for(object)
        key = %i(name title label).find{|k| object.respond_to?(k) && object.send(k).present? }
        key ? object.send(key) : object.class.to_s.demodulize.underscore.humanize
      end

      protected

      def controller_title
        controller.archetype_name.to_s.humanize
      end
    end
  end
end
