module Archetype
  module Router
    def self.mount(app_router, opts={}, &block)
      inject_routes(app_router, &block) if block_given?
      app_router.mount Archetype::Engine => opts[:path]
    end

    def self.inject_routes(app_router, &block)
      Archetype::Engine.routes.draw do
        instance_eval(&block)
      end
    end
  end
end
