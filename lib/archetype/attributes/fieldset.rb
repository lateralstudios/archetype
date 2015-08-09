module Archetype
  module Attributes
    class Fieldset
      attr_accessor :name, :label, :options

      def initialize(name, opts={})
        @name = name.to_sym
        @label = opts.delete(:label)
        @options = opts
      end

      def label
        @label || name.to_s.humanize
      end
    end
  end
end
