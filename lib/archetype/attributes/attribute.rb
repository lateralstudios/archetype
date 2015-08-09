module Archetype
  module Attributes
    class Attribute
      attr_accessor :name, :type, :contexts, :options

      def initialize(name, type, options={})
        @name = name.to_sym
        @type = type.to_sym
        @contexts = options.delete(:contexts){ [] }
        @options = options || {}
      end

      def fieldset
        options[:fieldset] || :default
      end

      def column
        options[:column]
      end

      alias_method :param, :name

      def from(object)
        object.send(name)
      end

      def update(params)
        params.each{|k,v| send("#{k}=", v) if respond_to?("#{k}=") }
        %i(type column).each{|k| send("#{k}=", value = params.delete(k)) if value }
        self.contexts = filter_contexts(contexts.dup, params.delete(:context))
        self.options = params
      end

      def presenter_class
        return options[:presenter_class] if options.key?(:presenter_class)
        type_presenter || default_presenter
      end

      private

      def type_presenter
        default_presenter.descendants.find{|c| c.name.demodulize == "#{type.to_s.classify}Presenter" }
      end

      def default_presenter
        Presenters::AttributePresenter
      end

      def self.for_type?(type)
        name.demodulize == type.to_s.classify
      end
    end
  end
end
