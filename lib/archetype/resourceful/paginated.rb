module Archetype
  module Resourceful
    module Paginated
      extend ActiveSupport::Concern

      included do
        has_scope :page, default: 1, only: :index
        has_scope :per, default: archetype.resourceful.per_page, only: :index
      end

      module ClassMethods
      end
    end
  end
end
