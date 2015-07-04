module Archetype
  module Attributes
    class AssociationPresenter < AttributePresenter
      def from(object)
        return name_from(super) unless many?
        super.map{|o| name_from(o) }
      end

      def field
        SimpleForm::Association.new(self)
      end

      private

      def name_from(object)
        key = %i(name title label).find{|k| object.respond_to?(k) && object.send(k).present? }
        key ? object.send(key) : object.to_s
      end
    end
  end
end
