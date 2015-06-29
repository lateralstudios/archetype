module Archetype
  module Interface
    class Presenter
      attr_reader :controller

      def initialize(controller)
        @controller = controller
      end

      def site_name
        Archetype.application.config.site_name
      end

      def meta_title
        [title, Array.wrap(site_name).join(' ')].join(' | ')
      end

      def title
        @title ||= build_title
      end

      def name_for(object)
        key = %i(name title label).find{|k| object.respond_to?(k) && object.send(k).present? }
        key ? object.send(key) : object.class.to_s.demodulize.underscore.humanize
      end

      def navigation
        @navigation ||= Navigation.new(build_navigation, current_navigation)
      end

      def breadcrumbs
        @breadcrumbs ||= Breadcrumb.new(controller.class._crumbs)
      end

      protected

      def current_navigation
        controller.class.try(:_navigation)
      end

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
