module Archetype
  module Attributes
    class Builder
      include Archetype::ModuleBuilder

      def build_attributes
        super do |attributes|
          attributes.each do |name, attribute|
            if index = attribute.options[:position]
              configuration.attributes.insert(index, attribute)
            else
              configuration.attributes << attribute
            end
          end
        end
      end

      def configuration
        @configuration ||= Attributes::Configuration.new
      end

      class << self
        def attributes(*args)
          opts = args.extract_options!
          names = args.delete(:all) ? builders.map(&:name) : args
          names.each do |name|
            builder = attribute_builders[name] || AttributeBuilder.new(name)
            attribute_builders[name] = builder.from_hash(opts)
          end
        end
        alias_method :attribute, :attributes
        alias_method :association, :attributes

        def attribute_model(model)
          builders = ModelFactory.new(model).build
          builders.each do |builder|
            attribute_builders[builder.name] = builder
          end
        end

        def attribute_builders
          builders[:attributes] ||= HashBuilder.new
        end
      end
    end
  end
end
