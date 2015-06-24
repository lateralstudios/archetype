require 'archetype/interface'

module Archetype
  module Base
    extend ActiveSupport::Concern
    include Archetype::Interface

    included do
    end

    def archetype_name
      self.class.archetype_name
    end
    
    module ClassMethods
      def archetype_name
        controller_name
      end
    end
  end
end
