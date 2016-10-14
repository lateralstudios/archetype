module Archetype
  module Interface
    class Configuration
      attr_accessor :navigation
      attr_writer :crumbs
      
      def crumbs
        @crumbs ||= [home_crumb]
      end

      private

      def home_crumb
        Crumb.new(:home, :root)
      end
    end
  end
end
