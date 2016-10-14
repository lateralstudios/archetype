module Archetype
  class ModelBuilder
    include Builder
    dsl_accessor :name, :options

    def initialize(options={})
      @options = process_options(options || {})
    end

    def dsl_method
      as || name.try(:to_sym)
    end

    def from_hash(h)
      @options.merge!(process_options(h))
      self
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
