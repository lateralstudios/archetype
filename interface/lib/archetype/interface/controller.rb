module Archetype
  module Interface
    class Controller
      include Archetype::Module

      def base_build_class
        Builder
      end
    end
  end
end
