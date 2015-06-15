require "jquery-rails"
require "bootstrap-sass"
require "archetype/application"
require "archetype/base"
require "archetype/dashboard"
require "archetype/resourceful"
require "archetype/router"
require "archetype/engine"

module Archetype
  class << self
    attr_accessor :application

    delegate :interface, to: :application

    def application
      @application ||= Archetype::Application.new
    end
  end

  def self.mount(app_router, opts={}, &block)
    Archetype::Router.mount app_router, opts, &block
  end
end
