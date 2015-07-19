module Archetype
  module Attributes
    module Presenters
      class BooleanPresenter < AttributePresenter
        def short_format(object)
          yes_or_no(object)
        end

        def long_format(object)
          yes_or_no(object)
        end

        private

        def yes_or_no(object)
          from(object) ? 'Yes' : 'No'
        end
      end
    end
  end
end
