module Archetype
  module Attributes
    class Builder
      include Archetype::ModuleBuilder

      builds :attributes, :fieldsets, with: HashBuilder

      class << self
        def fieldset(name, opts={})
          name = name.to_sym
          fieldset = builders[:fieldsets].fetch(name){ FieldsetBuilder.new }
          fieldset.from_hash(opts.merge({name: name}))
          builders[:fieldsets][name] = fieldset
        end

        def attributes(*args)
          opts = args.extract_options!
          names = args.delete(:all) ? builders[:attributes].keys : args.map(&:to_sym)
          names.reverse! if opts[:position]
          names.each do |name|
            builder = builders[:attributes].fetch(name){ AttributeBuilder.new }
            builders[:attributes][name] = builder.from_hash(opts.merge(name: name))
          end
        end
        alias_method :attribute, :attributes

        def association(*args)
          opts = args.extract_options!
          args.reverse! if opts[:position]
          args.each do |name|
            builder = builders[:attributes].fetch(name){ AssociationBuilder.new }
            builders[:attributes][name] = builder.from_hash(opts.merge(name: name))
          end
        end

        def attribute_model(model)
          attr_builders = ModelFactory.new(model).build
          attr_builders.each do |builder|
            builders[:attributes][builder.name] = builder
          end
        end
      end

      fieldset :default, label: 'General', position: 0

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
          attributes.each do |name, attribute|
            if index = attribute.options[:position]
              configuration.attributes.insert(index, attribute)
            else
              configuration.attributes << attribute
            end
            add_to_fieldset(attribute)
          end
        end
      end

      def configuration
        @configuration ||= Attributes::Configuration.new
      end

      private

      def add_to_fieldset(attribute)
        name = attribute.name
        return if configuration.fieldsets.any?{|f| f.has_attribute?(name) }
        if attribute.is_a?(Association) && attribute.nested?
          fieldset = (builders[:fieldsets][name] ||= FieldsetBuilder.new({name: name, label: attribute.label}))
        else
          fieldset = builders[:fieldsets][:default]   
        end
        fieldset.attributes << attribute.name
      end
    end
  end
end
