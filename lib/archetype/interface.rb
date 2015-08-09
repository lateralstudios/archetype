require 'archetype/interface/navigable'
require 'archetype/interface/navigation'
require 'archetype/interface/breadcrumb'
require 'archetype/interface/crumb'
require 'archetype/interface/configuration'
require 'archetype/interface/controller'
require 'archetype/interface/builder'
require 'archetype/interface/controller_presenter'
require 'archetype/interface/presenter'

module Archetype
  module Interface
    extend ActiveSupport::Concern

    included do
      layout 'archetype/application'
      helper_method :interface

      archetype.module(:interface, Interface::Controller)
      archetype.interface do |controller|
        crumb controller.archetype_name
      end
    end

    def interface
      @interface ||= Presenter.new(archetype_controller.interface, self) 
    end
  end
end
