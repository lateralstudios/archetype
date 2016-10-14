module Archetype
  module Attributes
    module Presenters
      class AssociationPresenter < AttributePresenter
        def nested
          @nested ||= AttributeSet.new(super.presenters(h)).any_context
        end

        def field(form, object=nil)
          return SimpleForm::Nested.new(self, form, object) if nested?
          SimpleForm::Association.new(self, form, object)
        end

        def name_from(object)
          key = %i(name title label).find{|k| object.respond_to?(k) && object.send(k).present? }
          key ? object.send(key) : object.to_s
        end
      end
    end
  end
end
