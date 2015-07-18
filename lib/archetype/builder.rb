module Archetype
  module Builder
    extend ActiveSupport::Concern
    NULL = Object.new.freeze

    included do
      dsl_accessor :as
      alias_method :dsl_method, :as
    end

    def build(&block)
      yield(self)
    end

    module ClassMethods
      def dsl_accessor(*args)
        attr_writer *args
        args.each do |accessor|
          define_method accessor do |value=NULL|
            return instance_variable_get("@#{accessor}") if value == NULL
            send("#{accessor}=", value)
          end
        end
      end
    end
  end
end
