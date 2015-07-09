module Archetype
  module Attributes
    class ModelFactory
      attr_reader :model

      def initialize(model)
        @model = model
        build if model.table_exists?
      end

      def attributes
        @attributes ||= []
      end
      
      def associations
        @associations ||= []
      end

      def build
        model.columns.each do |column|
          add_column(column)
        end
        add_associations
      end

      def add_associations
        used = associations.map{|a| a.options[:association] }
        (model_associations - used).each do |assoc|
          add_association assoc
        end
      end

      def add_column(column)
        name = column.name.to_sym
        association = find_model_association(name)
        return add_association(association, column) if association
        return add_uploader(uploaders[name], column) if uploaders[name]
        add_attribute(column)
      end

      def add_attribute(column)
        options = {
          name: column.name,
          type: column.type,
          column: column
        }
        attributes << AttributeFactory.new(options).attribute
      end

      def add_association(association, column=nil)
        options = {
          name: association.name,
          type: association.macro,
          column: column,
          association: association
        }
        association = AttributeFactory.new(options).attribute
        associations << association
        attributes << association
      end

      def add_uploader(uploader, column)
        options = {
          name: column.name,
          type: :uploader,
          column: column,
          uploader: uploader
        }
        attributes << AttributeFactory.new(options).attribute
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
