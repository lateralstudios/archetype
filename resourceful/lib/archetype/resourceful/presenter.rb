module Archetype
  module Resourceful
    class Presenter < Interface::ControllerPresenter
      attr_accessor :config

      def initialize(config, controller)
        @config = config
        super(controller)
      end

      def title
        build_resource_title
      end

      def resource?
        controller.send(:resource).present?
      rescue ActiveRecord::RecordNotFound # TODO tying to an adaptor..
        false
      end

      def can_show?
        config.actions.include?(:show)
      end

      def can_new?
        config.actions.include?(:new)
      end

      def can_destroy?
        config.actions.include?(:destroy)
      end

      def can_edit?
        config.actions.include?(:edit)
      end

      def resource
        return unless resource?
        @resource ||= ResourcePresenter.new(controller.send(:resource))
      end

      def collection
        controller.send(:collection)
      end
      
      def filtered_collection
        controller.send(:filtered_collection)
      end

      def resource_name
        controller.class.resource_instance_name.to_s.humanize
      end

      def resource_instance_name
        name_for(resource)
      end

      def collection_name
        controller.class.resource_collection_name.to_s.humanize
      end

      protected

      def build_resource_title
        if resource
          case controller.action_name
          when 'new'
            "<small>New</small> #{resource_name}"
          when 'edit'
            "<small>Edit</small> #{resource_instance_name}"
          else
            resource_name
          end
        else
          collection_name
        end
      end
      
      def attributes
        controller.attributes
      end
    end
  end
end
