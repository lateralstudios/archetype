module Archetype
  module Resourceful
    class Controller
      include Archetype::Module

      def base_build_class
        Builder
      end
    end
  end
end
