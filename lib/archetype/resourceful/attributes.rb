require 'archetype/resourceful/attribute_set'
require 'archetype/resourceful/attribute'

module Archetype
  module Resourceful
    module Attributes
      extend ActiveSupport::Concern

      included do
        delegate :attributes, to: :class
      end

      module ClassMethods
        def attributes
          @attributes ||= AttributeSet.from_model(resource_class)
        end

        # def attribute(*args)
      end
    end
  end
end
