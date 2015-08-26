module Archetype
  class HashBuilder
    include Builder
    extend Forwardable
    def_delegators :@hash, :[], :[]=, :any?, :key?, :inject, :fetch, :merge, :merge!

    def initialize(hash={})
      @hash = hash
    end

    def initialize_clone(other)
      @hash = other.instance_variable_get(:@hash).clone
      super
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
