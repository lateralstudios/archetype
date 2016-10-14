module Archetype
  class <%= class_name %>Controller < ApplicationController
    include Archetype::Base
    
    archetype.config do
      navigable :<%= file_name %>, ->{  }, icon: 'link'
    end
  end
end
