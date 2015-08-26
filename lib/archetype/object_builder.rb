module Archetype
  class ObjectBuilder
    include Builder
    dsl_accessor :object

    def initialize(object=nil)
      @object = object
    end

    def build(delegate)
      super
      @object
    end
    
    private

    def build_from_delegate(delegate)
      @object = super
    end
  end
end
