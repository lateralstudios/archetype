module Archetype
  module Interface
    class Presenter
      attr_reader :controller

      def initialize(controller)
        @controller = controller
      end

      def title
        @title ||= build_title
      end

      def navigation
        @navigation ||= Navigation.new(build_navigation)
      end

      def breadcrumbs
        @breadcrumbs ||= Breadcrumb.new(controller.class._crumbs)
      end

      protected

      def build_title
        controller.archetype_name.humanize
      end

      def build_navigation
        navigable = Archetype.controllers.map do |_, c|
          c._navigation if c.respond_to?(:_navigation)
        end.compact
      end
    end
  end
end
