module Archetype
  module Resourceful
    module Attributes
      module SimpleForm
        class Association < Input
          def form_method
            input_options[:method] || :association
          end
        end
      end
    end
  end
end
