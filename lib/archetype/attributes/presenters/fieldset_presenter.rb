module Archetype
  module Attributes
    module Presenters
      class FieldsetPresenter < SimpleDelegator
        attr_accessor :attributes

        def initialize(fieldset)
          @fieldset = fieldset
          super(fieldset)
        end
        
        def fields(context, form, object)
          attributes.for(context).map{|a| a.field(form, object) }
        end

        def empty?(context=nil)
          (context ? attributes.for(context) : attributes).empty?
        end

        def extract_attributes(all_attributes)
          attrs = @fieldset.attributes.map do |name|
            all_attributes.find{|a| a.name == name }
          end.compact
          @attributes = AttributeSet.new(attrs)
        end
      end
    end
  end
end
