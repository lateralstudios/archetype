module Archetype
  module Resourceful
    class Configuration
      attr_reader :controller
      attr_writer :actions, :per_page, :attributes

      def initialize(controller)
        @controller = controller
      end

      def actions
        @actions ||= default_actions
      end

      def attributes
        @attributes ||= Archetype::Resourceful::Attributes::AttributeSet.from_model(controller.resource_class)
      end

      def per_page
        @per_page ||= 25
      end

      def default_actions
        Archetype::Resourceful::RESOURCEFUL_ACTIONS
      end
      
      module DSL
        def actions(*args)
          opts = args.extract_options!
          default_actions = resourceful.default_actions
          actions = resourceful.actions.dup
          actions = [] if args.delete(:none)
          actions = default_actions if args.delete(:all)
          actions = Array.wrap(opts[:only]) if opts.key?(:only)
          actions = actions - Array.wrap(opts[:except]) if opts.key?(:except)
          actions |= args if args.any?
          (default_actions - actions).each do |a|
            undef_method(a, "#{a}!")
          end
        end

        def attributes(*args)
          opts = args.extract_options!
          attributes = args.delete(:all) ? resourceful.attributes : resourceful.attributes.find(args)
          to_create = args - attributes.map(&:name)
          attributes.update(opts.clone)
          to_create.each{|a| resourceful.attributes.new(a, opts.clone) }
        end
        alias_method :attribute, :attributes

        def per_page(per)
          resourceful.per_page = per
          controller.scopes_configuration[:per][:default] = per
        end
      end
    end
  end
end
