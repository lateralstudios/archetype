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

        def attributes(*args, &block)
          opts = args.extract_options!
          names = args.delete(:all) ? builders[:attributes].keys : args.map(&:to_sym)
          names.reverse! if opts[:position]
          names.each do |name|
            attr_opts = opts.merge(name: name)
            attr_opts[:block] = block if block_given?
            builder = builders[:attributes].fetch(name){ AttributeBuilder.for(opts[:type]).new }
            builders[:attributes][name] = builder.from_hash(attr_opts)
          end
        end
        alias_method :attribute, :attributes

        def association(*args)
          opts = args.extract_options!
          args.reverse! if opts[:position]
          args.each do |name|
            builder = builders[:attributes].fetch(name){ AssociationBuilder.for(opts[:type]).new }
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
          end
          update_fieldset_builders(attributes)
        end
      end

      def configuration
        @configuration ||= Attributes::Configuration.new
      end

      private

      def update_fieldset_builders(attributes)
        default_fieldset = builders[:fieldsets][:default]
        default_fieldset.attributes = []
        attributes.each_value{|a| add_to_fieldset(a) }
      end

      def add_to_fieldset(attribute)
        name = attribute.name
        return if builders[:fieldsets].values.any?{|f| f.attributes.include?(name) }
        if attribute.is_a?(Association) && attribute.nested?
          fieldset = (builders[:fieldsets][name] ||= FieldsetBuilder.new({name: name, label: attribute.label}))
        else
          fieldset = builders[:fieldsets][:default]   
        end
        fieldset.attributes += [attribute.name]
      end
    end
  end
end
