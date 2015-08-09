module Archetype
  class HashBuilder
    include Builder
    extend Forwardable
    def_delegators :@hash, :[], :[]=, :any?, :key?, :inject, :merge, :merge!

    def initialize(hash={})
      @hash = hash
    end

    def build(delegate)
      return {} unless any?
      inject({}) do |sum, (key, object)|
        object = object.build(delegate) if object.respond_to?(:build)
        sum[key] = object
        sum
      end
    end

    def to_hash
      @hash
    end
  end
end
