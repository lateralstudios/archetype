module Archetype
  class ObjectBuilder
    include Builder
    def from_hash(h)
      h.each { |k, v| send(k, v) }
      self
    end
  end
end
