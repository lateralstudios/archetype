module Archetype
  module Attributes
    module Presenters
      class TextPresenter < AttributePresenter
        def short_format(object)
          truncate(sanitize(from(object)), length: 150)
        end

        def long_format(object)
          h.content_tag(:div, super(object).html_safe, class: 'froala-view')
        end
      end
    end
  end
end
