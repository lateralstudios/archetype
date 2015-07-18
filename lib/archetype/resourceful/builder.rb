module Archetype
  module Resourceful
    class Builder
      include Archetype::ModuleBuilder

      def build_actions
        super do |actions|
          (self.class.default_actions - actions).each do |a|
            undefine_action(a)
          end
          configuration.actions = actions
        end
      end

      def build_per_page
        super do |per|
          configuration.per_page = per
          controller.scopes_configuration[:per][:default] = per
        end
      end

      def configuration
        @configuration ||= Resourceful::Configuration.new
      end

      private

      def undefine_action(action)
        controller.class_eval do
          undef_method(action, "#{action}!")
        end
      end

      class << self
        def actions(*args)
          builders[:actions] ||= ArrayBuilder.new
          actions = process_action_args(args, builders[:actions].to_a.dup)
          builders[:actions] = ArrayBuilder.new(actions)
        end

        def per_page(per)
          builders[:per_page] ||= ObjectBuilder.new(per)
        end

        # ActionsBuilder class..
        def process_action_args(args, actions=[])
          actions ||= []
          opts = args.extract_options!
          actions = [] if args.delete(:none)
          actions = default_actions if args.delete(:all)
          actions = Array.wrap(opts[:only]) if opts.key?(:only)
          actions = actions - Array.wrap(opts[:except]) if opts.key?(:except)
          actions |= args if args.any?
          actions
        end

        def default_actions
          Archetype::Resourceful::RESOURCEFUL_ACTIONS.clone
        end
      end
    end
  end
end
