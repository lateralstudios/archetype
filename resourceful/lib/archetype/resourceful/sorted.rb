module Archetype
  module Resourceful
    module Sorted
      extend ActiveSupport::Concern

      included do
        # has_scope :page, default: 1, only: :index
        # has_scope :per, only: :index
      end

      def filtered_collection
        if can_sort?
          super.order(sort_attribute => sort_direction)
        else
          super
        end
      end

      def sort_attribute
        return :created_at unless params[:sort_by].present?
        params[:sort_by].to_sym
      end

      def sort_direction
        return :desc unless params[:sort_direction].present? && %i(desc asc).include?(params[:sort_direction].to_sym)
        params[:sort_direction].to_sym
      end

      def can_sort?
        sort_attribute.present? && resourceful.sortable_attributes.map(&:name).include?(sort_attribute)
      end

      module ClassMethods
      end
    end
  end
end
