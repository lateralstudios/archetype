module Archetype
  class ObjectBuilder
    include Builder
    dsl_accessor :name, :options

    def initialize(name, options={})
      @name = name
      @options = process_options(options || {})
    end

    def dsl_method
      as || name.to_sym
    end

    private

    def process_options(opts)
      opts.inject({}) do |sum, (k, v)|
        if respond_to?("#{k}=")
          send("#{k}=", v)
        else
          sum[k] = v
        end
        sum
      end
    end
  end
end
