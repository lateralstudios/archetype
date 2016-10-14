module Archetype
  module Attributes
    module Presenters
      class AttributePresenter < SimpleDelegator
        def initialize(attribute, view_context)
          @view_context = view_context
          super(attribute)
        end

        def short_format(object)
          from(object)
        end

        def long_format(object)
          from(object)
        end

        def field(form, object=nil)
          SimpleForm::Input.new(self, form, object)
        end

        private

        def h
          @view_context
        end
      end
    end
  end
end
