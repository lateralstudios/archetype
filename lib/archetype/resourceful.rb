require 'responders'
require 'archetype/resourceful/resource'
require 'archetype/resourceful/actions'
require 'archetype/resourceful/interface'

module Archetype
  module Resourceful
    extend ActiveSupport::Concern
    include Resource
    include Actions

    included do
      prepend_view_path 'app/views/archetype/resource'
      # Archetype::Interface.send(:include, Archetype::Resourceful::Interface)
    end

    module ClassMethods
      def local_prefixes
        super.push('archetype/resource')
      end
    end
  end
end
