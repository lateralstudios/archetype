require 'responders'
require 'has_scope'
require 'kaminari'
require 'simple_form'
require 'archetype/resourceful/base'
require 'archetype/resourceful/attributes'
require 'archetype/resourceful/actions'
require 'archetype/resourceful/dsl'
require 'archetype/resourceful/presenter'
require 'archetype/resourceful/resource_presenter' # just resource.rb ?
require 'archetype/resourceful/parameters'
require 'archetype/resourceful/paginated'

module Archetype
  module Resourceful
    extend ActiveSupport::Concern

    RESOURCEFUL_ACTIONS = [:index, :show, :new, :create, :edit, :update, :destroy]

    include Base
    include Actions
    include Attributes
    include Parameters
    include Paginated

    included do
      extend DSL

      prepend_view_path 'app/views/archetype/resource'
      helper_method :resourceful
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
