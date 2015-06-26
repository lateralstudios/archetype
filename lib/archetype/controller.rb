module Archetype
  class Controller < SimpleDelegator
    attr_accessor :controller

    def initialize(controller)
      self.controller = controller
      super(controller)
    end
  end
end
