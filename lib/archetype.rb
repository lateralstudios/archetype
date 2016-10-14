require 'archetype_core'
require 'archetype_interface'
require 'archetype_attributes'
require 'archetype_resourceful'
require 'archetype_dashboard'

module Archetype
  class << self
    attr_accessor :application

    delegate :controllers, :register, to: :application

    def application
      @application ||= Archetype::Application.new
    end

    def configure
      yield(application.config)
    end

    def reload!
      application.reload!
    end
  end

  def self.mount(app_router, opts={}, &block)
    Archetype::Core::Router.mount app_router, opts, &block
  end
end
