module Archetype
  module Resourceful
    module Parameters
      extend ActiveSupport::Concern
      
      included do
        define_method "#{resource_instance_name}_params" do
          context = case action_name
          when 'create'
            :new
          when 'update'
            :edit
          else
            action_name.to_sym
          end
          attr_params = resourceful.attributes(context).map(&:param)
          params.require(resource_instance_name).permit(attr_params)
        end
        protected "#{resource_instance_name}_params"
      end

      private

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
