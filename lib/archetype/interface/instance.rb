module Archetype
  module Interface
    class Instance
      attr_accessor :controller

      def initialize(controller)
        @controller = controller
      end

      def title
        @title ||= build_title
      end

      def navigation
        @navigation ||= prepare_navigation
      end

      # def breadcrumbs
      #   @breadcrumbs ||= Breadcrumbs.new
      # end

      protected

      def build_title
        controller.archetype_name.humanize
      end

      def prepare_navigation
        navigable = []
        Archetype.controllers.each do |_, c|
          navigable << c.navigation if c.respond_to?(:navigation)
        end
        Navigation.new(navigable.compact)
      end
    end
  end
end
