require 'responders'
require 'has_scope'
require 'kaminari'
require 'simple_form'
require 'archetype/attributes'
require 'archetype/resourceful/base'
require 'archetype/resourceful/actions'
require 'archetype/resourceful/resource_presenter' # just resource.rb ?
require 'archetype/resourceful/parameters'
require 'archetype/resourceful/paginated'
require 'archetype/resourceful/configuration'
require 'archetype/resourceful/controller'
require 'archetype/resourceful/builder'
require 'archetype/resourceful/presenter'

module Archetype
  module Resourceful
    extend ActiveSupport::Concern

    RESOURCEFUL_ACTIONS = [:index, :show, :new, :create, :edit, :update, :destroy]

    included do
      include Archetype::Attributes
      archetype.module(:resourceful, Resourceful::Controller)

      include Base
      include Actions
      include Parameters
      include Paginated

      helper_method :resourceful

      archetype.attributes do |controller|
        attribute_model controller.resource_class
      end
    end

    def resourceful
      @resourceful ||= Presenter.new(archetype_controller.resourceful, self)
    end

    module ClassMethods
      def local_prefixes
        super.insert(-2, 'archetype/resource')
      end
    end
  end
end
