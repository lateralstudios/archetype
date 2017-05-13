module Archetype
  module Attributes
    class Presenter < Interface::ControllerPresenter
      attr_accessor :config
      delegate :[], :find, :find_all, to: :attributes

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
          Presenters::FieldsetPresenter.new(fieldset).tap do |presenter|
            presenter.extract_attributes(attribute_presenters)
          end
        end
      end

      def attributes
        @attributes ||= AttributeSet.new(attribute_presenters)
      end

      def attribute_presenters
        @attribute_presenters ||= config.attributes.map{|a| a.presenter_class.new(a, h) }
      end

      def h
        controller.view_context
      end
    end
  end
end
