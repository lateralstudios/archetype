module Archetype
  module Resourceful
    module Attributes
      class Attribute
        attr_accessor :name, :type, :contexts, :column, :options

        def initialize(name, type=nil, options={})
          @name = name.to_sym
          @type = (type || 'string').to_sym
          @contexts = options.delete(:contexts){ default_contexts }
          @column = options.delete(:column) # This should be #column
          @options = options || {}
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
          %i(type column).each{|k| send("#{k}=", value = params.delete(k)) if value }
          self.contexts = filter_contexts(contexts.dup, params.except!(%i(only except on contexts)))
          self.options = params
        end

        private

        def default_contexts
          return [] if %i(id created_at updated_at).include?(name)
          contexts  = [:new, :edit, :show, :create, :update] 
          contexts += [:index] unless type == :text
          contexts
        end

        def filter_contexts(contexts, params={})
          contexts = Array.wrap(params[:only]) if params[:only]
          contexts = (contexts - Array.wrap(params[:except])) if params[:except]
          contexts = (contexts + Array.wrap(params[:on])).uniq if params[:on]
          contexts
        end

        def self.from_column(column)
          new(column.name, column.type, {column: column})
        end
      end
    end
  end
end
