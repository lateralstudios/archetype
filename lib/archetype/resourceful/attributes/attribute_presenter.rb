module Archetype
  module Resourceful
    module Attributes
      class AttributePresenter < SimpleDelegator
        def short_format(object)
          from(object)
        end

        def long_format(object)
          from(object)
        end

        def label
          name.to_s.humanize
        end

        def field
          Attributes::SimpleForm::Input.new(self)
        end
      end
    end
  end
end
