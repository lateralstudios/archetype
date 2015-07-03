module Archetype
  module Resourceful
    module Attributes
      class AssociationPresenter < AttributePresenter
        def field
          SimpleForm::Association.new(self)
        end
      end
    end
  end
end
