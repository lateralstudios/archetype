module Archetype
  class ArrayBuilder
    include Builder
    extend Forwardable
    def_delegators :@array, :<<, :+, :length, :any?, :collect, :find

    def initialize(array=[])
      @array = array
    end

    def build(&block)
      return [] unless any?
      collect do |object|
        object = object.build(&block) if object.respond_to?(:build)
        object
      end
    end

    def to_a
      @array
    end
  end
end
