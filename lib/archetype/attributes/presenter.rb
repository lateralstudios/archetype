module Archetype
  module Attributes
    class Presenter < Interface::ControllerPresenter
      attr_accessor :config
      delegate :[], to: :attributes

      def initialize(config, controller)
        @config = config
        super(controller)
      end

      def for(context=default_context)
        attributes.for(context)
      end
      alias_method :all, :for

      def fieldsets(context=default_context)
        fieldset_presenters.reject{|f| f.empty?(context) }
      end

      def fieldset(name)
        fieldset_presenters.find{|f| f.name == name.to_sym}
      end

      def default_context
        controller.action_name.to_sym
      end
      alias_method :context, :default_context

      private

      def fieldset_presenters
        @fieldset_presenters ||= config.fieldsets.map do |fieldset|
          attrs = attributes.for_fieldset(fieldset.name)
          Presenters::FieldsetPresenter.new(fieldset, attrs)
        end
      end

      def attributes
        @attributes ||= AttributeSet.new(config.attributes.map{|a| a.presenter_class.new(a, h) })
      end

      def h
        controller.view_context
      end
    end
  end
end
