require "archetype/base"
require "archetype/dashboard"
require "archetype/resourceful"

module Archetype
  class BaseController < ActionController::Base
    include Archetype::Base

    # This will ideally be in an included hook on the Base module, 
    # but with a BaseController, we'll have to stick to this for now.
    def self.inherited(base)
      Archetype.register(base)
    end
  end
end
