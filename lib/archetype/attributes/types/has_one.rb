module Archetype
  module Attributes
    module Types
      class HasOne < Association
        def many?
          false
        end

        def param
          return nested_params if nested?
          name = super
          name.to_s.foreign_key.to_sym
        end

        private

        def default_presenter
          Presenters::HasOnePresenter
        end
      end
    end
  end
end
