module Archetype
  module Dashboard
    extend ActiveSupport::Concern

    included do
    end

    def show

    end

    module ClassMethods
      def controller_path
        'dashboard'
      end
    end
  end
end

