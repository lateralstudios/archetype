module Archetype
  module Resourceful
    class ResourcePresenter < SimpleDelegator
      attr_accessor :resource
      delegate :class, to: :resource

      def initialize(resource)
        @resource = resource
        super(resource)
      end

      alias_method :form_object, :resource
    end
  end
end
