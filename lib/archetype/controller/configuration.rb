module Archetype
  class Controller < SimpleDelegator
    class Configuration
      attr_accessor :controller, :configs

      def initialize(controller)
        self.controller = controller
        self.configs = {}
      end

      def new_config(name, config)
        integrate_config(name, config)
      end

      private

      def method_missing(m, *args, &block)
        return configs[m] if configs[m]
        super
      end

      def integrate_config(name, config)
        self.configs[name] = config
        if dsl = config.class.const_get(:DSL)
          extend(dsl)
        end
      end
    end
  end
end
