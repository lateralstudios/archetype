require "jquery-rails"
require "bootstrap-sass"
require "archetype/router"
require "archetype/engine"

module Archetype
  def self.mount(app_router, opts={}, &block)
    Archetype::Router.mount app_router, opts, &block
  end
end
