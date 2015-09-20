module Archetype
  module Attributes
    module SimpleForm
      class Association < Input
        def form_method
          options[:method] || :association
        end
      end
    end
  end
end
