require 'responders'
require 'archetype/resourceful/base'
require 'archetype/resourceful/attributes'
require 'archetype/resourceful/actions'
require 'archetype/resourceful/dsl'
require 'archetype/resourceful/presenter'

module Archetype
  module Resourceful
    extend ActiveSupport::Concern

    RESOURCEFUL_ACTIONS = [:index, :show, :new, :create, :edit, :update, :destroy]

    include Base
    include Actions
    include Attributes

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
