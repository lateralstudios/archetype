module Archetype
  module Resourceful
    module Actions
      extend ActiveSupport::Concern

      included do
        respond_to :html
      end

      module ClassMethods
        def _actions
          @_actions ||= default_actions
        end

        def default_actions
          Archetype::Resourceful::RESOURCEFUL_ACTIONS
        end
      end


      # GET /resources
      def index(options={}, &block)
        respond_with(collection, options, &block)
      end

      # GET /resources/1
      def show(options={}, &block)
        respond_with(resource, options, &block)
      end

      # GET /resources/new
      def new(options={}, &block)
        respond_with(build_resource, options, &block)
      end

      # GET /resources/1/edit
      def edit(options={}, &block)
        respond_with(resource, options, &block)
      end

      # POST /resources
      def create(options={}, &block)
        object = build_resource

        create_resource(object)
        respond_with(resource, options, &block)
      end

      # PUT /resources/1
      def update(options={}, &block)
        object = resource

        update_resource(object, resource_params)
        respond_with(resource, options, &block)
      end

      # DELETE /resources/1
      def destroy(options={}, &block)
        object = resource

        destroy_resource(object)
        respond_with(resource, options, &block)
      end

      alias :index! :index
      alias :show! :show
      alias :new! :new
      alias :edit! :edit
      alias :create! :create
      alias :update! :update
      alias :destroy! :destroy
      protected :index!, :show!, :new!, :create!, :edit!, :update!, :destroy!

    end
  end
end
