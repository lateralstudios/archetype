module Archetype
  module Attributes
    class TextBuilder < AttributeBuilder
      dsl_accessor :wysiwyg

      def build_wysiwyg
        @wysiwyg || false
      end

      def wysiwyg=(value)
        @wysiwyg = value
        if value
          existing = input[:html].try(:[], :class)
          new = [existing, 'wysiwyg'].compact.join(' ')
          input(html: {class: new})
        end
      end

      def attribute_options
        super.deep_merge({
          wysiwyg: wysiwyg
        })
      end
    end
  end
end
