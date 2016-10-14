module Archetype
  module Interface
    class Presenter < ControllerPresenter
      attr_reader :config

      def initialize(config, controller)
        @config = config
        super(controller)
      end

      def site_name
        Archetype.application.config.site_name
      end

      def meta_title
        [title, Array.wrap(site_name).join(' ')].join(' | ')
      end

      def navigation
        @navigation ||= Navigation.new(build_navigation, current_navigation).ordered
      end

      def breadcrumbs
        @breadcrumbs ||= Breadcrumb.new(config.crumbs)
      end

      protected

      def current_navigation
        config.navigation
      end

      def build_navigation
        navigable = Archetype.controllers.map do |_, c|
          c.interface.navigation if c.module?(:interface)
        end.compact
      end
    end
  end
end
