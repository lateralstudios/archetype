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
        resourceful_class._attributes.for(context)
      end

      def form_attributes(context=nil)
        attributes(context).map{|a| Attributes::SimpleFormInput.new(a) }
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

      def resourceful_class
        @resourceful.class
      end
    end
  end
end
