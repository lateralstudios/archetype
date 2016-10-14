module Archetype
  class <%= class_name %>Controller < ApplicationController
    include Archetype::Base
    include Archetype::Resourceful
    
    archetype.config do
      navigable :<%= file_name %>, ->{  }, icon: 'link'

      # attributes :telephone, :email, context: {except: :index}
    end
  end
end
