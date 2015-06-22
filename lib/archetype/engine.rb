module Archetype
  class Engine < ::Rails::Engine
    isolate_namespace Archetype

    initializer 'archetype.reload' do
      unless Rails.configuration.cache_classes
        ActionDispatch::Reloader.to_prepare do
          Archetype.reload!
        end
      end
    end
  end
end
