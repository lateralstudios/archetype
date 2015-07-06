module Archetype
  class ResourceGenerator < Rails::Generators::NamedBase
    desc "Generates a resourceul Archetype controller"
    source_root File.expand_path('../templates', __FILE__)

    def copy_controller_file
      template "resourceful_controller.rb", "app/controllers/archetype/#{file_name}_controller.rb"
    end
  end
end
