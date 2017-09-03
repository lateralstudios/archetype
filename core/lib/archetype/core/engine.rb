module Archetype
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace Archetype
      engine_name 'archetype'

      initializer 'archetype.autoload' do
        # TODO: Should just load the controllers
        Rails.application.eager_load!
        unless Rails.configuration.cache_classes
          # ActionDispatch::Reloader.to_cleanup do
          #   Archetype.reload!
          # end
        end
      end

      initializer 'archetype.configure_controllers' do
        Rails.application.config.after_initialize do
          Archetype.controllers.each_value(&:configure)
        end
      end
    end
  end
end
