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

    def reload!
      @_reload = true
    end

    private

    def reload_controllers
      class_names = controllers.values.map{|c| c.controller.to_s }
      @controllers = {}
      class_names.each do |const| 
        remove_const(const) if const_defined?(const)
        const.constantize 
      end
      @_reload = false
    end
  end
end
