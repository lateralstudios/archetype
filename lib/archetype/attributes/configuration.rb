module Archetype
  module Attributes
    class Configuration
      attr_reader :controller
      attr_writer :attributes

      def initialize(controller)
        @controller = controller
      end

      def attributes
        @attributes ||= Attributes::AttributeSet.new
      end

      module DSL
        def attributes(*args)
          opts = args.extract_options!
          to_update = args.delete(:all) ? configs[:attributes].attributes : configs[:attributes].attributes.only(args)
          to_create = args - to_update.map(&:name)
          to_update.update(opts.clone)
          to_create.each{|a| configs[:attributes].attributes.new(a, opts.clone) }
        end
        alias_method :attribute, :attributes

        def attribute_model(model)
          configs[:attributes].attributes.merge Attributes::AttributeSet.from_model(model)
        end
      end
    end
  end
end
