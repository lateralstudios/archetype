module Archetype
  module Resourceful
    class Presenter < SimpleDelegator
      attr_accessor :resourceful

      delegate :archetype_name, :attributes, to: :resourceful_class

      def initialize(resourceful)
        @resourceful = resourceful
        super(resourceful)
      end

      def attributes(context=nil)
        configuration.attributes.for(context).map(&:presenter)
      end

      def form_attributes(context=nil)
        attributes(context).map(&:field)
      end

      def resource
        return unless resourceful_resource
        @resource ||= ResourcePresenter.new(resourceful_resource, self)
      end

      def collection
        @collection ||= resourceful.send(:collection)
      end

      private

      def resourceful_resource
        resourceful.send(:resource)
      end

      def configuration
        @resourceful.configuration.resourceful
      end
    end
  end
end
