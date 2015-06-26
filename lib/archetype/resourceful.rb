require 'responders'
require 'archetype/resourceful/resource'
require 'archetype/resourceful/attributes'
require 'archetype/resourceful/actions'
require 'archetype/resourceful/dsl'
require 'archetype/resourceful/presenter'

module Archetype
  module Resourceful
    RESOURCEFUL_ACTIONS = [:index, :show, :new, :create, :edit, :update, :destroy]

    extend ActiveSupport::Concern
    include Resource
    include Attributes
    include Actions

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
