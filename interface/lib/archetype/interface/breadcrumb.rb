module Archetype
  module Interface
    class Breadcrumb
      attr_accessor :crumbs 

      def initialize(*crumbs)
        @crumbs = crumbs.flatten
      end
    end
  end
end
