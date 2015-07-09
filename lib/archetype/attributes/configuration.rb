module Archetype
  module Attributes
    class Configuration
      attr_reader :controller
      attr_writer :attributes

      def initialize(controller)
        @controller = controller
      end

      def attributes
        @attributes ||= []
      end

      def update_attributes(names, params)
        to_update = attributes.find_all{|a| names.include?(a.name) }
        to_create = names - to_update.map(&:name)
        position = params.delete(:position)
        to_update.reverse.each do |attribute|
          index = position || attributes.index(attribute)
          attributes.delete(attribute)
          attributes.insert(index, AttributeFactory.new(params.clone, attribute).attribute)
        end
        to_create.reverse.each do |a|
          attribute = AttributeFactory.new({name: a}.merge(params.clone)).attribute
          if position
            attributes.insert(position, attribute)
          else
            attributes << attribute
          end
        end
      end

      def from_model(model)
        self.attributes += ModelFactory.new(model).attributes
      end

      module DSL
        def attributes(*args)
          opts = args.extract_options!
          names = args.delete(:all) ? configs[:attributes].attributes.map(&:name) : args
          configs[:attributes].update_attributes(names, opts)
        end
        alias_method :attribute, :attributes
        alias_method :association, :attributes

        def attribute_model(model)
          configs[:attributes].from_model(model)
        end
      end
    end
  end
end
