module Archetype
  module Resourceful
    class ResourcePresenter < SimpleDelegator
      attr_accessor :resourceful, :resource
      delegate :class, to: :resource

      def initialize(resource, resourceful)
        @resource = resource
        @resourceful = resourceful
        super(resource)
      end

      alias_method :form_object, :resource
    end
  end
end
