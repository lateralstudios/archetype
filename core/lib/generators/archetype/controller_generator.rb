module Archetype
  class ControllerGenerator < Rails::Generators::NamedBase
    desc "Generates an Archetype controller"
    source_root File.expand_path('../templates', __FILE__)

    def copy_controller_file
      template "controller.rb", "app/controllers/archetype/#{file_name}_controller.rb"
    end
  end
end
