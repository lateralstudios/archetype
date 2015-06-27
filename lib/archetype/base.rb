require 'archetype/interface'

module Archetype
  module Base
    extend ActiveSupport::Concern

    included do
      extend BaseHelpers
      include Archetype::Interface

      Archetype.register(self)
      delegate :archetype_name, to: :class
    end
    
    module BaseHelpers
      def archetype_name
        controller_name
      end

      def archetype_controller
        Archetype.controllers[archetype_name.to_sym]
      end
    end

  end
end
