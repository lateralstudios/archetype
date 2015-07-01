require 'archetype/interface/configuration'
require 'archetype/interface/presenter'
require 'archetype/interface/navigable'
require 'archetype/interface/navigation'
require 'archetype/interface/breadcrumb'
require 'archetype/interface/crumb'

module Archetype
  module Interface
    extend ActiveSupport::Concern

    class << self
      def config_for(controller)
        Configuration.new(controller)
      end
    end

    included do
      layout 'archetype/application'
      helper_method :interface

      archetype.module(:interface, Interface)
      archetype.config do
        crumb controller.archetype_name
      end
    end

    def interface
      @interface ||= Presenter.new(self) 
    end
  end
end
