module Archetype
  module Attributes
    class TextBuilder < AttributeBuilder
      dsl_accessor :wysiwyg

      def wysiwyg(value=NULL)
        wysiwyg = @wysiwyg || false
        return wysiwyg if value == NULL
        self.wysiwyg = value
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
