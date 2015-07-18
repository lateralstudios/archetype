require 'archetype/interface'

module Archetype
  module Dashboard
    extend ActiveSupport::Concern

    included do
      include Archetype::Interface
      # archetype.module(:dashboard, Dashboard)

      archetype.interface do
        navigable :dashboard, ->{ :root }, icon: 'home', position: 0
      end
    end

    def show

    end

    module ClassMethods
      def local_prefixes
        super.push('archetype/dashboard')
      end
    end
  end
end

