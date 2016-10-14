module Archetype
  module Interface
    class Engine < ::Rails::Engine
      isolate_namespace Archetype
      engine_name 'archetype'
    end
  end
end

