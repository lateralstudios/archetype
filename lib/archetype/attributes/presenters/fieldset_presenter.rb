module Archetype
  module Attributes
    module Presenters
      class FieldsetPresenter < SimpleDelegator
        attr_accessor :attributes

        def initialize(fieldset, attributes=[])
          @fieldset = fieldset
          @attributes = attributes
          super(fieldset)
        end
        
        def fields(context, form, object)
          attributes.for(context).map{|a| a.field(form, object) }
        end

        def empty?(context=nil)
          (context ? attributes.for(context) : attributes).empty?
        end
      end
    end
  end
end
