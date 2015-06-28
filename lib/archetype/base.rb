require 'archetype/interface'

module Archetype
  module Base
    extend ActiveSupport::Concern

    included do
      extend BaseHelpers
      include Archetype::Interface

      Archetype.register(self)
      delegate :archetype_name, to: :class
      helper_method :archetype_user
    end

    def archetype_user
      send(Archetype.application.config.user_method)
    end
    
    module BaseHelpers
      def archetype_name
        controller_name
      end

      def archetype_controller
        Archetype.controllers[archetype_name.to_sym]
      end

      def local_prefixes
        super.push('archetype/base')
      end
  
      # TODO: untested, probably works..
      def inherited?(base)
        super
        Archetype.register(base)
      end
    end

  end
end
