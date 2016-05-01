module Archetype
  module Builder
    extend ActiveSupport::Concern
    NULL = Object.new.freeze

    included do
      dsl_accessor :as
      alias_method :dsl_method, :as
    end

    def build(delegate)
      build_from_delegate(delegate) if delegate_can_build?(delegate)
    end
    
    def configure(&block)
      instance_exec(&block)
    end

    def from_hash(h)
      h.each { |k, v| send(k, v) }
      self
    end

    private

    def delegate_can_build?(delegate)
      dsl_method && delegate.respond_to?(dsl_method)
    end

    def build_from_delegate(delegate)
      delegate.send(dsl_method, self)
    end

    module ClassMethods
      def dsl_accessor(*args)
        attr_writer *args
        args.each do |accessor|
          define_method accessor do |value=NULL|
            return send("build_#{accessor}") if value == NULL
            send("#{accessor}=", value)
          end

          define_method "build_#{accessor}" do
            instance_variable_get("@#{accessor}")
          end
        end
      end
    end
  end
end
