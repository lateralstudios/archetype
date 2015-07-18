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
      self.modules[name] = mod.new(self)
    end

    def config(&block)
      configuration.instance_exec(&block)
    end

    def method_missing(m, *args, &block)
      if self.modules[m]
        call_module(m, args, &block)
      else
        super
      end
    end

    private

    def call_module(name, args, &block)
      mod = modules[name]
      return mod.configuration unless args.any? || block_given?
      configure_module(mod, args, &block)
    end

    def configure_module(mod, args, &block)
      mod.builder = args[0] if args.count == 1
      mod.builder.class_exec(self, &block) if block_given?
      mod.configure
    end

    def initialize_config
      Configuration.new(self)
    end
  end
end
