module Archetype
  module Attributes
    class Builder
      include Archetype::ModuleBuilder

      def initialize(controller)
        # TODO We need to initialize the builders for the dynamic build
        # Protocol needed
        class_builders[:attributes] ||= HashBuilder.new
        class_builders[:fieldsets] ||= HashBuilder.new
        self.class.fieldset(:default, label: 'General', position: 0)
        super
      end

      def build
        build_fieldsets
        build_attributes
      end

      def build_fieldsets
        super do |fieldsets|
          fieldsets.each do |name, fieldset|
            if index = fieldset.options[:position]
              configuration.fieldsets.insert(index, fieldset)
            else
              configuration.fieldsets << fieldset
            end
          end
        end
      end

      def build_attributes
        super do |attributes|
          add_missing_fieldsets(attributes.map{|_, a| a.fieldset }.compact.uniq)
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

      private

      def add_missing_fieldsets(names)
        names.each do |name|
          name = name.to_sym
          next if class_builders[:fieldsets].key?(name)
          class_builders[:fieldsets][name] = FieldsetBuilder.new(name) 
        end
      end

      class << self
        def fieldset(name, opts={})
          name = name.to_sym
          attrs = opts.delete(:attributes)
          fieldset_builders[name] = FieldsetBuilder.new(name, opts)
          attributes(*attrs, fieldset: name) if attrs && attrs.any?
        end

        def attributes(*args)
          opts = args.extract_options!
          names = args.delete(:all) ? attribute_builders.keys : args.map(&:to_sym)
          names.reverse! if opts[:position]
          names.each do |name|
            builder = attribute_builders[name] || AttributeBuilder.new(name)
            attribute_builders[name] = builder.from_hash(opts)
          end
        end
        alias_method :attribute, :attributes

        def association(*args)
          opts = args.extract_options!
          args.reverse! if opts[:position]
          args.each do |name|
            builder = attribute_builders[name] || AssociationBuilder.new(name)
            attribute_builders[name] = builder.from_hash(opts)
          end
        end

        def attribute_model(model)
          builders = ModelFactory.new(model).build
          builders.each do |builder|
            attribute_builders[builder.name] = builder
          end
        end

        def attribute_builders
          builders[:attributes] ||= HashBuilder.new
        end

        def fieldset_builders
          builders[:fieldsets] ||= HashBuilder.new
        end
      end
    end
  end
end
