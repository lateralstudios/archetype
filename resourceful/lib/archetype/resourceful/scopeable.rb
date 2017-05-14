module Archetype
  module Resourceful
    module Scopeable
      extend ActiveSupport::Concern

      included do
        helper_method :current_scope
      end

      def filtered_collection
        if can_scope?
          resourceful.scopes[current_scope].results(super, params[current_scope])
        else
          super
        end
      end

      def current_scope
        resourceful.scopes.keys.find{|s| params[s].present? }
      end

      def can_scope?
        current_scope.present? && valid_scope_value?(current_scope, params[current_scope])
      end

      def valid_scope_value?(scope, value)
        return true unless resourceful.scopes[scope].multiple?
        resourceful.scopes[scope].values.map(&:last).include?(value)
      end

      module ClassMethods
      end
    end
  end
end
