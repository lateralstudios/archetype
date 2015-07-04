module Archetype
  module Attributes
    class AttributeSet < SimpleDelegator
      def initialize(attributes=[])
        super(attributes)
      end

      def new(name, opts={})
        attribute = Attribute.new(name, opts.delete(:type), opts)
        __getobj__ << attribute
        attribute
      end

      def [](name)
        find(name).first
      end

      def only(*names)
        self.class.new(with_names(names.flatten))
      end

      def for(context=nil)
        return self unless context.present?
        self.class.new(with_context(context))
      end

      def merge(attributes)
        __setobj__(__getobj__ + attributes)
      end

      def update(params)
        each{|a| a.update(params.clone) }
      end

      private

      def with_names(names)
        find_all{|a| names.include?(a.name) }
      end

      def with_context(context)
        find_all{|a| a.contexts.include?(context) }
      end

      def self.from_model(model)
        new(discover_attributes(model))
      end

      def self.discover_attributes(model)
        return [] unless model.table_exists?
        associations = model.reflect_on_all_associations
        model.columns.map do |column|
          association = associations.find{|a| a.foreign_key == column.name}
          next Association.from_column(column, association) if association
          Attribute.from_column(column)
        end
      end
    end
  end
end
