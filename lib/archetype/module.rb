module Archetype
  module Module
    extend ActiveSupport::Concern

    included do
      attr_reader :controller
    end

    module ClassMethods
      def module_name
        @module_name ||= name.split('::')[1].underscore.to_sym
      end
    end

    def initialize(controller)
      @controller = controller
      @defaults = []
    end

    def configuration
      @configuration || configure
    end

    def configure
      @configuration = build_class.configure(controller)
    end

    def build_block(&block)
      build_class.class_exec(controller, &block)
    end

    def set_build_class(klass)
      @build_class = klass
    end

    def build_class
      @build_class ||= generate_build_class
    end

    # Defaults need refactoring
    Default = Struct.new(:block)

    def defaults(*args, &block)
      opts = args.extract_options!
      @defaults += [Default.new(block)]
    end

    def apply_defaults(klass)
      @defaults.each do |default|
        klass.class_exec(controller, &default.block)
      end
    end

    private 

    def generate_build_class
      return @builder_name.to_s.constantize if @builder_name.present?
      Class.new(base_build_class).tap do |klass|
        apply_defaults(klass)
      end
    end

    def base_build_class
      raise NotImplementedError
    end
  end
end
