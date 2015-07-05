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

      def build
        model.columns.each do |column|
          add_column(column)
        end
      end

      def add_column(column)
        name = column.name.to_sym
        return add_association(associations[name], column) if associations[name]
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

      def add_association(association, column)
        options = {
          name: association.name,
          type: association.macro,
          column: column,
          association: association
        }
        attributes << AttributeFactory.new(options).attribute
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

      def associations
        @associations ||= model.reflect_on_all_associations.inject({}) do |sum, assoc|
          sum[assoc.foreign_key.to_sym] = assoc
          sum
        end
      end

      def uploaders
        model.uploaders
      end
    end
  end
end
