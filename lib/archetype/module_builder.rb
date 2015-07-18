module Archetype
  module ModuleBuilder
    extend ActiveSupport::Concern

    def initialize(controller)
      @controller = controller
    end

    def configure
      build
      configuration
    end

    def build(&block)
      class_builders.each do |key, builder|
        send("build_#{key}", &block)
      end
    end

    def build_builder(key, builder, &block)
      object = builder.build do |builder|
        build_method(builder, builder.dsl_method)
      end
      return yield(object) if block_given?
      configuration.send("#{key}=", object)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def build_method(builder, method)
      return unless respond_to?(method)
      send(method, builder)
    end

    def method_missing(m, *args, &block)
      key = m[/build_(.*)/,1]
      if key && builder = class_builders[key.to_sym]
        build_builder(key.to_sym, builder, &block)
      else
        super
      end
    end

    private

    def controller
      @controller
    end

    def class_builders
      self.class.builders
    end
    
    module ClassMethods
      def builders
        @builders ||= {}
      end

      def configure(controller)
        new(controller).configure
      end
    end
  end
end
