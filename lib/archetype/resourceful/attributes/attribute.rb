module Archetype
  module Resourceful
    module Attributes
      class Attribute
        attr_accessor :name, :type, :contexts, :column, :options

        ATTRIBUTE_CLASSES = {
        }

        def initialize(name, type=nil, options={})
          @name = name.to_sym
          @type = (type || 'string').to_sym
          @contexts = filter_contexts(default_contexts, options.delete(:context))
          @column = options.delete(:column) 
          @options = options || {}
        end

        def presenter
          @presenter ||= AttributePresenter.new(self)
        end

        alias_method :param, :name

        def from(object)
          object.send(name)
        end

        def update(params)
          params.each{|k,v| send("#{k}=", v) if respond_to?("#{k}=") }
          %i(type column).each{|k| send("#{k}=", value = params.delete(k)) if value }
          self.contexts = filter_contexts(contexts.dup, params.delete(:context))
          self.options = params
        end

        private

        def default_contexts
          return [] if %i(id created_at updated_at).include?(name)
          contexts  = [:new, :edit, :show, :create, :update] 
          contexts += [:index] unless type == :text
          contexts
        end

        def filter_contexts(contexts, *args)
          return contexts unless args.any?
          filters = args.extract_options!
          return [] if args.include?(:none)
          contexts = args if args.any?
          contexts = (contexts - Array.wrap(filters[:except])) if filters[:except]
          contexts = (contexts + Array.wrap(filters[:on])).uniq if filters[:on]
          contexts.flatten
        end

        def self.from_column(column)
          class_for(column).new(column.name, column.type, {column: column})
        end

        def self.class_for(column)
          ATTRIBUTE_CLASSES[column.type.to_sym] || self
        end
      end
    end
  end
end
