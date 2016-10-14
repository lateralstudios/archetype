module Archetype
  class Controller < SimpleDelegator
    class Configuration
      attr_accessor :controller

      def initialize(controller)
        self.controller = controller
      end
    end
  end
end
