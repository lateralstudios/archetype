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

        def label
          options[:label] || name.to_s.humanize
        end

        def field
          SimpleForm::Input.new(self)
        end

        def h
          @view_context
        end
      end
    end
  end
end
