require 'archetype/interface'

module Archetype
  module Base
    extend ActiveSupport::Concern
    include Archetype::Interface

    included do
      delegate :archetype_name, to: :class
    end
    
    module ClassMethods
      def archetype_name
        controller_name
      end
    end
  end
end
