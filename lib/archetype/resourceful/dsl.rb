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
          undef_method(a, "#{a}!")
        end
      end

      def attributes(*args)
        opts = args.extract_options!
        _attributes.find(args).update(opts)
      end
      alias_method :attribute, :attributes

      def per_page(per)
        @_per_page = per
        has_scope :per, default: _per_page
      end
    end
  end
end
