module Archetype
  module Interface
    class Controller
      include Archetype::Module

      def builder
        @builder ||= Class.new(Builder)
      end
    end
  end
end
