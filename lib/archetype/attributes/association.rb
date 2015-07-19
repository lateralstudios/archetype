module Archetype
  module Attributes
    class Association < Attribute
      attr_accessor :nested

      def initialize(name, macro, options={})
        super(name, macro, options)
      end

      def association
        options[:association]
      end

      def nested
        @nested ||= {}
      end

      def nested?
        nested.any?
      end

      def many?
        %i(has_many has_many_or_belongs_to).include?(type)
      end

      def param
        return nested_params if nested?
        name = column.try(:name) || super
        return name.to_s.foreign_key.to_sym if type == :belongs_to
        name
      end

      private

      def nested_params
        param_name = "#{name.to_s.pluralize}_attributes".to_sym
        params = {}
        params[param_name] = [:id, :_destroy] + nested.map{|_,v| v.param }
        params
      end

      def default_presenter
        Presenters::AssociationPresenter
      end
    end
  end
end
