module Archetype
  module Resourceful
    class ResourcePresenter < SimpleDelegator
      attr_accessor :resourceful, :resource

      def initialize(resource, resourceful)
        @resource = resource
        @resourceful = resourceful
        super(resource)
      end

      def name
        name_attribute.from(resource)
      end

      def name_attribute
        @name_attribute ||= resourceful.attributes.detect(to_s_attribute) do |attr|
          %i(name title label).include?(attr.name)
        end
      end

      private
      
      def to_s_attribute
        Attributes::Attribute.new(:to_s)
      end
    end
  end
end
