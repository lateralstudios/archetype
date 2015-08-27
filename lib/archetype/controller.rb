require 'archetype/controller/configuration'

module Archetype
  class Controller < SimpleDelegator
    class ModuleNotFound < StandardError; end
    attr_accessor :controller, :modules, :configuration

    def initialize(controller)
      self.controller = controller
      self.modules = {}
      self.configuration = initialize_config
      super(controller)
    end
    
    def configure
      modules.each_value(&:configure)
    end

    def module?(name)
      modules.key?(name.to_sym)
    end

    def module(module_class)
      name = module_class.module_name
      self.modules[name] = module_class.new(self)
    end

    def defaults(name, *args, &block)
      raise ModuleNotFound unless module?(name)
      modules[name].defaults(*args, &block)
    end

    def config(&block)
      configuration.instance_exec(&block)
    end

    def method_missing(m, *args, &block)
      if self.modules[m]
        call_module(m, *args, &block)
      else
        super
      end
    end

    private

    def call_module(name, *args, &block)
      mod = modules[name]
      return mod.configuration unless args.any? || block_given?
      configure_module(mod, *args, &block)
    end

    def configure_module(mod, *args, &block)
      opts = args.extract_options!
      build_class = args[0]
      if build_class.present?
        mod.set_build_class(build_class)
      elsif block_given?
        mod.build_block(&block)
      end
    end

    def initialize_config
      # This does.. nothing right now. 
      Configuration.new(self) 
    end
  end
end
