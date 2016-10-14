module Archetype
  module Attributes
    module Presenters
      class HasManyPresenter < AssociationPresenter
        def short_format(object)
          from(object).count
        end

        def long_format(object)
          from(object).map{|o| name_from(o) }.join(', ')
        end
      end
    end
  end
end
