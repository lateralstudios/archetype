module Archetype
  module Resourceful
    module Searchable
      extend ActiveSupport::Concern

      included do
        # has_scope :page, default: 1, only: :index
        # has_scope :per, only: :index
      end

      def filtered_collection
        if can_search?
          super.where(search_query, keyword: search_keyword)
        else
          super
        end
      end

      def search_query
        resourceful.searchable_attributes.map do |attribute|
          "#{attribute.column.name} LIKE :keyword" 
        end.join(' OR ')
      end

      def search_keyword
        return nil unless params[:search].present?
        "%#{params[:search]}%"
      end

      def can_search?
        resourceful.searchable? && search_keyword.present?
      end

      module ClassMethods
      end
    end
  end
end
