module Archetype
  module Resourceful
    class Builder
      include Archetype::ModuleBuilder

      builds :actions, with: ArrayBuilder
      builds :per_page, with: ObjectBuilder
      builds :scopes, with: HashBuilder

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
        end
      end

      def build_scopes
        super do |scopes|
          scopes.each do |name, scope|
            configuration.scopes[name.to_sym] = scope
          end
        end
      end

      def configuration
        @configuration ||= Resourceful::Configuration.new
      end

      private

      def undefine_action(action)
        controller.class_eval do
          undef_method(action) if method_defined?(action)
          undef_method("#{action}!") if method_defined?("#{action}!")
        end
      end

      class << self
        def actions(*args)
          actions = process_action_args(args, builders[:actions].to_a.dup)
          builders[:actions] = ArrayBuilder.new(actions)
        end

        def scopes(*args)
          opts = args.extract_options!
          args.each do |name|
            builder = builders[:scopes][name] || Scope::Builder.new
            builder.from_hash(opts.merge(name: name))
            builders[:scopes][name] = builder
          end
        end

        def per_page(per)
          builders[:per_page].object = per
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
