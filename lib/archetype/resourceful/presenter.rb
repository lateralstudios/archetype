module Archetype
  module Resourceful
    class Presenter < SimpleDelegator
      attr_accessor :resourceful

      delegate :attributes, to: :resourceful_class

      def initialize(resourceful)
        @resourceful = resourceful
        super(resourceful)
      end

      def attributes(context=nil)
        resourceful_class._attributes.for(context)
      end

      def resource
        @resource ||= ResourcePresenter.new(resourceful.send(:resource), self)
      end

      def collection
        @collection ||= resourceful.send(:collection)
      end

      private

      def resourceful_class
        @resourceful.class
      end
    end
  end
end
