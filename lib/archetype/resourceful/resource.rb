module Archetype
  module Resourceful
    module Resource
      extend ActiveSupport::Concern

      included do
        helper_method :collection, :resource
      end

      protected

      def collection
        get_collection_ivar || begin
          c = end_of_association_chain
          set_collection_ivar(c.is_a?(ActiveRecord::Relation) ? c : c.all)
        end
      end

      def resource
        get_resource_ivar || set_resource_ivar(end_of_association_chain.send(method_for_find, params[:id]))
      end

      def build_resource
        get_resource_ivar || set_resource_ivar(end_of_association_chain.send(method_for_build, *resource_params))
      end

      def create_resource(object)
        object.save
      end

      def update_resource(object, attributes)
        object.update_attributes(*attributes)
      end

      def destroy_resource(object)
        object.destroy
      end

      def resource_class
        @resource_class ||= archetype_name.classify.safe_constantize
      end

      private

      def end_of_association_chain 
        apply_scopes_if_available(resource_class)
      end

      def method_for_build 
        :build
      end

      def method_for_find
        :find
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

      def resource_collection_name
        archetype_name.to_sym
      end

      def resource_instance_name
        archetype_name.singularize.to_sym
      end

      def resource_params
        parameters = permitted_params || params
        parameters[resource_instance_name] || {}
      end

      def permitted_params
        return nil unless respond_to?("#{resource_instance_name}_params", true)
        {resource_instance_name => send("#{resource_instance_name}_params")}
      rescue ActionController::ParameterMissing
        # typically :new action
        if params[:action].to_s == 'new'
          {resource_instance_name => {}}
        else
          raise
        end
      end
    end
  end
end
