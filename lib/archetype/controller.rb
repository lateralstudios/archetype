require 'archetype/controller/configuration'

module Archetype
  class Controller < SimpleDelegator
    attr_accessor :controller, :modules, :configuration

    def initialize(controller)
      self.controller = controller
      self.modules = {}
      self.configuration = initialize_config
      super(controller)
    end

    def module?(name)
      modules.key?(name.to_sym)
    end

    def module(name, mod)
      #TODO: raise if modules.key?(name)
      self.modules[name] = mod
      configuration.new_config(name, mod.config_for(controller)) if mod.respond_to?(:config_for)
    end

    def config(&block)
      configuration.instance_exec(&block)
    end

    private

    def initialize_config
      Configuration.new(self)
    end
  end
end
