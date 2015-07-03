require 'archetype/resourceful/attributes/attribute_set'
require 'archetype/resourceful/attributes/attribute'
require 'archetype/resourceful/attributes/association'
require 'archetype/resourceful/attributes/attribute_presenter'
require 'archetype/resourceful/attributes/association_presenter'
require 'archetype/resourceful/attributes/simple_form/input'
require 'archetype/resourceful/attributes/simple_form/association'

module Archetype
  module Resourceful
    module Attributes
      extend ActiveSupport::Concern

      included do
      end

      module ClassMethods
      end
    end
  end
end
