require 'responders'
require 'has_scope'
require 'kaminari'
require 'simple_form'
require 'archetype/attributes'
require 'archetype/resourceful/configuration'
require 'archetype/resourceful/base'
require 'archetype/resourceful/actions'
require 'archetype/resourceful/presenter'
require 'archetype/resourceful/resource_presenter' # just resource.rb ?
require 'archetype/resourceful/parameters'
require 'archetype/resourceful/paginated'

module Archetype
  module Resourceful
    extend ActiveSupport::Concern

    RESOURCEFUL_ACTIONS = [:index, :show, :new, :create, :edit, :update, :destroy]

    class << self
      def config_for(controller)
        Configuration.new(controller)
      end
    end

    included do
      prepend_view_path 'app/views/archetype/resource'
      helper_method :resourceful

      archetype.module(:resourceful, Resourceful)

      include Archetype::Attributes

      include Base
      include Actions
      include Parameters
      include Paginated

      archetype.config do
        attribute_model controller.resource_class
      end
    end

    def resourceful
      @resourceful ||= Presenter.new(self)
    end

    module ClassMethods
      def local_prefixes
        super.push('archetype/resource')
      end
    end
  end
end
