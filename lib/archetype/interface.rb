require 'archetype/interface/navigation'
require 'archetype/interface/navigable'

module Archetype
  class Interface
    def navigable(name, path, opts={})
      navigation.add_parent(name, path, opts)
    end

    def navigation
      @navigation ||= Navigation.new
    end
  end
end
