module Archetype
  class HashBuilder
    include Builder
    extend Forwardable
    def_delegators :@hash, :[], :[]=, :any?, :inject, :merge, :merge!

    def initialize(hash={})
      @hash = hash
    end

    def build(&block)
      return {} unless any?
      inject({}) do |sum, (key, object)|
        object = object.build(&block) if object.respond_to?(:build)
        sum[key] = object
        sum
      end
    end

    def to_hash
      @hash
    end
  end
end
