module Archetype
  module Resourceful
    module Attributes
      class Association < Attribute
        attr_accessor :association

        ASSOCIATION_CLASSES = {
          belongs_to: Association
        }

        def initialize(name, macro, options={})
          @association = options.delete(:association)
          super(name, macro, options)
        end

        def presenter
          @presenter ||= AssociationPresenter.new(self)
        end

        def param
          column.try(:name) || super
        end

        def self.from_column(column, association)
          class_for(association, column).new(association.name, association.macro, {column: column, association: association})
        end

        def self.class_for(association, column)
          ASSOCIATION_CLASSES[association.macro] || super(column)
        end
      end
    end
  end
end
