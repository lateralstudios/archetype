module Archetype
  module Attributes
    module Presenters
      class DatetimePresenter < AttributePresenter
        def short_format(object)
          format(object, '%d %B %Y %H:%M')
        end

        def long_format(object)
          format(object) do |value|
            value.strftime("#{value.day.ordinalize} %B %Y %H:%M:%S")
          end
        end

        def format(object, format=nil, &block)
          return unless value = from(object)
          format = yield(value) if block_given?
          value.strftime(format)
        end

        def field(form, object=nil)
          SimpleForm::Datetime.new(self, form, object)
        end
      end
    end
  end
end
