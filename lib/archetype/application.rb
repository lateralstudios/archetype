require "archetype/controller"

module Archetype
  class Application
    def register(controller)
      name = controller.archetype_name.to_sym
      controllers[name] = Controller.new(controller)
    end

    def controllers
      @controllers ||= {}
    end
  end
end
