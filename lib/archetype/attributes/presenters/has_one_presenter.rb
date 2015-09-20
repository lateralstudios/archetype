module Archetype
  module Attributes
    module Presenters
      class HasOnePresenter < AssociationPresenter
        def short_format(object)
          name_from(from(object))
        end

        def long_format(object)
          short_format(object)
        end

        def field(form, object=nil)
          return SimpleForm::Nested.new(self, form, object) if nested?
          SimpleForm::HasOne.new(self, form, object)
        end
      end
    end
  end
end
