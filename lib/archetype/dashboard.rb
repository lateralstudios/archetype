require 'archetype/interface'
require 'archetype/dashboard/navigable'
require 'archetype/dashboard/presenter'

module Archetype
  module Dashboard
    extend ActiveSupport::Concern

    included do
      include Archetype::Interface
      # archetype.module(:dashboard, Dashboard)

      helper_method :dashboard

      archetype.interface do
        navigable :dashboard, ->{ :root }, icon: 'home', position: 0
      end
    end

    def show

    end

    def dashboard
      @dashboard ||= Presenter.new(self) 
    end

    module ClassMethods
      def local_prefixes
        super.push('archetype/dashboard')
      end
    end
  end
end

