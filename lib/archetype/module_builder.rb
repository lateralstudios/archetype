module Archetype
  module ModuleBuilder # ConfigurationBuilder? 
    extend ActiveSupport::Concern

    def initialize(controller)
      @controller = controller
    end

    def configure
      build
      configuration
    end

    def build(&block)
      builders.each do |key, builder|
        send("build_#{key}", &block)
      end
    end

    def build_builder(key, builder, &block)
      object = builder.build(self)
      return yield(object) if block_given?
      configuration.send("#{key}=", object)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def method_missing(m, *args, &block)
      key = m[/build_(.*)/,1]
      if key && builder = builders[key.to_sym]
        build_builder(key.to_sym, builder, &block)
      else
        super
      end
    end

    private

    def controller
      @controller
    end

    included do
      class_attribute :builders

      self.builders = {}
    end

    module ClassMethods
      def builds(*args)
        opts = args.extract_options!
        build_class = opts[:with] || ObjectBuilder
        args.each do |name|
          self.builders[name.to_sym] = build_class.new
        end
      end

      def builder_for(controller)
        @controller = controller.archetype_controller
      end

      def apply_defaults!
        mod = @controller.modules[module_name]
        mod.apply_defaults(self)
      end

      def configure(controller)
        new(controller).configure
      end

      def inherited(base)
        # Clone builders to prevent propagation
        dup = builders.clone
        base.builders = dup.each{|k,v| dup[k] = v.clone }
        super
      end

      def module_name
        @module_name ||= superclass.name.split('::')[1].underscore.to_sym
      end
    end
  end
end
