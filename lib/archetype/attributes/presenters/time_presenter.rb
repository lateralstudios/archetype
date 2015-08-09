module Archetype
  module Attributes
    module Presenters
      class TimePresenter < DatetimePresenter
        def short_format(object)
          format(object, '%H:%M')
        end

        def long_format(object)
          format(object) do |value|
            value.strftime('%H:%M:%S')
          end
        end

        def field(form, object=nil)
          SimpleForm::Time.new(self, form, object)
        end
      end
    end
  end
end
