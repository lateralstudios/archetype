module Archetype
  module Attributes
    module Types
      class HasMany < Association
        def many?
          true
        end

        private

        def default_presenter
          Presenters::HasManyPresenter
        end
      end
    end
  end
end
