module Archetype
  module Attributes
    class Association < Attribute
      attr_accessor :association

      def initialize(name, macro, options={})
        super(name, macro, options)
      end

      def association
        options[:association]
      end

      def many?
        %i(has_many has_many_or_belongs_to).include?(type)
      end

      def presenter_class
        Presenters::AssociationPresenter
      end

      def param
        column.try(:name) || super
      end
    end
  end
end
