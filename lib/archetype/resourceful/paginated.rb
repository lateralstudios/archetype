module Archetype
  module Resourceful
    module Paginated
      extend ActiveSupport::Concern

      included do
        has_scope :page, default: 1, only: :index
        has_scope :per, default: 25, only: :index
      end
    end
  end
end
