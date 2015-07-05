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

      def param
        column.try(:name) || super
      end

      private

      def default_presenter
        Presenters::AssociationPresenter
      end
    end
  end
end
