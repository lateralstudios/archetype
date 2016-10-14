module Archetype
  module Attributes
    module SimpleForm
      class Datetime < Input
        def input(opts={})
          form.input name, opts.deep_merge(input_options) do 
            datetime_for(form)
          end
        end

        def datetime_for(form)
          h = form.template
          h.concat form.input_field(name, as: :hidden)
          h.concat(h.content_tag(:div, class: 'datetimepicker input-group datetime') do
            h.concat h.text_field_tag('', field_format(attribute.from(object)), {class: 'form-control', data: {format: 'dd/MM/yyyy hh:mm:ss'}})
            h.concat(h.content_tag(:span, class: 'add-on input-group-addon') do
              h.content_tag(:i, '', class: 'fa fa-calendar', data: {time_icon: 'fa fa-clock-o', date_icon: 'fa fa-calendar'})
            end)
          end)
        end

        def as
          super || :string
        end

        def field_format(datetime)
          return unless datetime.respond_to?(:strftime)
          datetime.strftime('%d/%m/%Y %H:%M:%S')
        end
      end
    end
  end
end
