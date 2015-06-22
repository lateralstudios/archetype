require 'archetype/interface/navigation'
require 'archetype/interface/navigable'
require 'archetype/interface/page'

module Archetype
  class Interface
    def page_for(controller)
      Page.new(controller)
    end

    def navigation
      @navigation ||= Navigation.new
    end

    # def breadcrumbs
    #   @breadcrumbs ||= Breadcrumbs.new
    # end
  end
end
