module Archetype
  module Attributes
    module Presenters
      class HasManyPresenter < AssociationPresenter
        def short_format(object)
          if block
            h.instance_exec(object, &block)
          else
            from(object).count
          end
        end

        def long_format(object)
          if block
            h.instance_exec(object, &block)
          else
            from(object).map{|o| name_from(o) }.join(', ')
          end
        end
      end
    end
  end
end
