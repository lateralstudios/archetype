module Archetype
  module Resourceful
    module Base
      extend ActiveSupport::Concern

      included do
        helper_method :resource_class
        delegate :resource_collection_name, :resource_instance_name, to: :class
      end

      module ClassMethods
        def resource_class
          resource_name.classify.safe_constantize
        end

        def resource_collection_name
          resource_name.to_sym
        end

        def resource_instance_name
          resource_name.singularize.to_sym
        end

        def resource_name
          controller_name
        end
      end

      protected

      def collection
        get_collection_ivar || begin
          c = end_of_association_chain
          set_collection_ivar(c.is_a?(ActiveRecord::Relation) ? c : c.all)
        end
      end

      def resource
        get_resource_ivar || set_resource_ivar(end_of_association_chain.send(method_for_find, params[id_param]))
      end

      def build_resource
        get_resource_ivar || set_resource_ivar(end_of_association_chain.send(method_for_build, resource_params))
      end

      def create_resource(object)
        object.save
      end

      def update_resource(object, attributes)
        object.update_attributes(attributes)
      end

      def destroy_resource(object)
        object.destroy
      end

      def resource_class
        @resource_class ||= self.class.resource_class
      end

      private

      def end_of_association_chain 
        apply_scopes_if_available(resource_class)
      end

      def method_for_build 
        :new
      end

      def method_for_find
        :find
      end

      def id_param
        :id
      end

      def get_resource_ivar 
        instance_variable_get("@#{resource_instance_name}")
      end

      def set_resource_ivar(resource) 
        instance_variable_set("@#{resource_instance_name}", resource)
      end

      def get_collection_ivar 
        instance_variable_get("@#{resource_collection_name}")
      end

      def set_collection_ivar(collection) 
        instance_variable_set("@#{resource_collection_name}", collection)
      end

      def apply_scopes_if_available(target_object) 
        respond_to?(:apply_scopes, true) ? apply_scopes(target_object) : target_object
      end

    end
  end
end
