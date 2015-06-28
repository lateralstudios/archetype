module Archetype
  module Resourceful
    class Attribute
      attr_accessor :name, :type, :contexts, :object

      def initialize(name, type=nil, options={})
        @name = name.to_sym
        @type = (type || 'string').to_sym
        @contexts = options[:contexts] || default_contexts
        @object = options[:object]
      end

      def label
        name.to_s.humanize
      end

      alias_method :param, :name

      def from(object)
        object.send(name)
      end

      def update(params)
        params.each{|k,v| send("#{k}=", v) if respond_to?("#{k}=") }
      end

      def only=(*contexts)
        @contexts = contexts.flatten
      end

      def except=(*contexts)
        @contexts = (@contexts - contexts.flatten)
      end

      def on=(*contexts)
        @contexts = (@contexts + contexts.flatten).uniq
      end

      private

      def default_contexts
        return [] if %i(id created_at updated_at).include?(name)
        contexts  = [:new, :edit, :show] 
        contexts += [:index] unless type == :text
        contexts
      end

      def self.from_column(column)
        new(column.name, column.type, {object: column})
      end
    end
  end
end
