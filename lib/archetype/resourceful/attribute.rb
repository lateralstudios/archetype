module Archetype
  module Resourceful
    class Attribute
      attr_accessor :name, :type, :contexts, :object

      def initialize(name, type, options={})
        @name = name.to_sym
        @type = type.to_sym
        @contexts = options[:contexts] || default_contexts
        @object = options[:object]
      end

      def label
        name.to_s.humanize
      end

      def from(object)
        object.send(name)
      end

      private

      def default_contexts
        return [] if %i(id created_at updated_at).include?(name)
        contexts  = [:new, :edit] 
        contexts += [:index] unless type == :text
        contexts
      end

      def self.from_column(column)
        new(column.name, column.type, {object: column})
      end
    end
  end
end
