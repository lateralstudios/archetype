module Archetype
  module Resourceful
    module Paginated
      extend ActiveSupport::Concern

      included do
        has_scope :page, default: 1, only: :index
        has_scope :per, default: _per_page, only: :index
      end

      module ClassMethods
        def _per_page
          @_per_page ||= 25
        end
      end
    end
  end
end
