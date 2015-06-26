module Archetype
  module Resourceful
    module DSL
      def actions(*args)
        opts = args.extract_options!
        @_actions = [] if args.delete(:none)
        @_actions = default_actions if args.delete(:all)
        @_actions = Array.wrap(opts[:only]) if opts.key?(:only)
        @_actions = @_actions - Array.wrap(opts[:except]) if opts.key?(:except)
        @_actions |= args if args.any?
        (RESOURCEFUL_ACTIONS - @_actions).each do |a|
          remove_method(a, "#{a}!")
        end
      end
    end
  end
end
