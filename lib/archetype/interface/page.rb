module Archetype
  class Interface
    class Page
      attr_accessor :controller

      def initialize(controller)
        @controller = controller
      end

      def title
        @title ||= build_title
      end

      protected

      def build_title
        controller.controller_name.humanize
      end
    end
  end
end
