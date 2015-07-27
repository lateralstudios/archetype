module Archetype
  module Attributes
    module Presenters
      class AssociationPresenter < AttributePresenter
        def nested
          @nested ||= AttributeSet.new(super.map{|_, a| a.presenter_class.new(a, h) })
        end

        def field(form, object=nil)
          SimpleForm::Association.new(self, form, object)
        end

        private

        def name_from(object)
          key = %i(name title label).find{|k| object.respond_to?(k) && object.send(k).present? }
          key ? object.send(key) : object.to_s
        end
      end
    end
  end
end
