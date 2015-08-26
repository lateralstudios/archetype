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

      def param
        return nested_params if nested?
        super
      end

      private

      def nested_params
        param_name = "#{name.to_s}_attributes".to_sym
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
