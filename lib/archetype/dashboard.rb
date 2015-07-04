module Archetype
  module Dashboard
    extend ActiveSupport::Concern

    included do
      archetype.module(:dashboard, Dashboard)

      archetype.config do
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

