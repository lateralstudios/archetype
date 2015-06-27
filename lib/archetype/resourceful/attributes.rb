require 'archetype/resourceful/attribute_set'
require 'archetype/resourceful/attribute'

module Archetype
  module Resourceful
    module Attributes
      extend ActiveSupport::Concern

      included do
      end

      module ClassMethods
        def _attributes
          @_attributes ||= AttributeSet.from_model(resource_class)
        end
      end
    end
  end
end
