module Archetype
  module Attributes
    module SimpleForm
      class Time < Input
        def input(opts={})
          form.input name, opts.deep_merge(input_options) do 
            time_for(form)
          end
        end

        def time_for(form)
          h = form.template
          h.concat form.input_field(name, as: :hidden)
          h.concat(h.content_tag(:div, class: 'timepicker input-group time') do
            h.concat h.text_field_tag('', field_format(attribute.from(object)), {class: 'form-control', data: {format: 'hh:mm:ss'}})
            h.concat(h.content_tag(:span, class: 'add-on input-group-addon') do
              h.content_tag(:i, '', class: 'fa fa-clock-o', data: {time_icon: 'fa fa-clock-o', date_icon: 'fa fa-calendar'})
            end)
          end)
        end

        def as
          super || :string
        end

        def field_format(datetime)
          return unless datetime.respond_to?(:strftime)
          datetime.strftime('%H:%M:%S')
        end
      end
    end
  end
end
