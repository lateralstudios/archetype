module Archetype
  module Resourceful
    class Presenter
      delegate :attributes, to: :resourceful_class

      def initialize(resourceful)
        @resourceful = resourceful
      end

      def attributes(context=nil)
        resourceful_class._attributes.for(context)
      end

      private

      def resourceful_class
        @resourceful.class
      end
    end
  end
end
