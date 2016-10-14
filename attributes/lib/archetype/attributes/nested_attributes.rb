module Archetype
  module Attributes
    class NestedAttributes < SimpleDelegator
      attr_reader :options

      def initialize(attributes={}, options={})
        @options = options
        super(attributes)
      end

      def allow_destroy?
        options[:allow_destroy]
      end

      def presenters(view_context)
        map{|_, a| a.presenter_class.new(a, view_context) }
      end

      def params(name)
        param_name = "#{name.to_s}_attributes".to_sym
        params = {}
        params[param_name] = [:id, :_destroy] + map{|_,v| v.param }
        params
      end
    end
  end
end
