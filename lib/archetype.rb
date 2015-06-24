require "jquery-rails"
require "bootstrap-sass"
require "archetype/engine"
require "archetype/application"
require "archetype/router"

module Archetype
  class << self
    attr_accessor :application

    delegate :controllers, :register, to: :application

    def application
      @application ||= Archetype::Application.new
    end

    def reload!
      @application = nil
    end
  end

  def self.mount(app_router, opts={}, &block)
    Archetype::Router.mount app_router, opts, &block
  end
end
