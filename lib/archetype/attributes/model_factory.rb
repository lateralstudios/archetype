module Archetype
  module Attributes
    class ModelFactory
      attr_reader :model

      def initialize(model)
        @model = model
      end

      def builders
        @builders ||= []
      end
      
      def build
        return builders unless model.table_exists?
        build_attributes
        build_associations
        builders
      end

      def build_attributes
        model.columns.each do |column|
          polymorphic_name = column.name.gsub('_type', '') if column.name.include?('_type')
          next if polymorphic_name && model.columns.any?{|c| c.name == "#{polymorphic_name}_id" }
          add_column(column)
        end
      end

      def build_associations
        used = builders.map{|a| a.options[:association] if a.options.key?(:association) }.compact
        (model_associations - used).each do |assoc|
          add_association assoc.name.to_sym, assoc
        end
      end

      def add_column(column)
        name = column.name.to_sym
        association = find_model_association(name)
        return add_association(association.name.to_sym, association, column) if association
        return add_uploader(name, uploaders[name], column) if uploaders[name]
        add_attribute(name, column)
      end

      def add_attribute(name, column)
        options = {
          type: column.type,
          column: column
        }
        builders << AttributeBuilder.new(name, options)
      end

      def add_association(name, association, column=nil)
        options = {
          type: association.macro,
          column: column,
          association: association,
          polymorphic: association.options[:polymorphic]
        }
        builders << AssociationBuilder.new(name, options)
      end

      def add_uploader(name, uploader, column)
        options = {
          type: :uploader,
          column: column,
          uploader: uploader
        }
        builders << AttributeBuilder.new(name, options)
      end

      private

      def model_associations
        @model_associations ||= model.reflect_on_all_associations
      end

      def find_model_association(foreign_key)
        model_associations.find{|a| a.foreign_key.to_sym == foreign_key.to_sym }
      end

      def uploaders
        model.uploaders
      end
    end
  end
end
