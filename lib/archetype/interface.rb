require 'archetype/interface/dsl'
require 'archetype/interface/presenter'
require 'archetype/interface/navigable'
require 'archetype/interface/navigation'
require 'archetype/interface/breadcrumb'
require 'archetype/interface/crumb'

module Archetype
  module Interface
    extend ActiveSupport::Concern

    included do
      extend DSL
      layout 'archetype/application'
      helper_method :interface
      crumb archetype_name
    end

    def interface
      @interface ||= Presenter.new(self) 
    end

    module ClassMethods
    end
  end
end
