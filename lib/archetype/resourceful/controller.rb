module Archetype
  module Resourceful
    class Controller
      include Archetype::Module

      def builder
        @builder ||= Class.new(Builder)
      end
    end
  end
end
