require 'archetype/interface'

module Archetype
  class Application
    def interface
      @interface ||= Interface.new
    end
  end
end
