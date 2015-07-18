module Archetype
  module Module
    extend ActiveSupport::Concern

    included do
      attr_reader :controller
      attr_accessor :builder
    end

    def initialize(controller)
      @controller = controller
    end

    def configuration
      @configuration ||= configure
    end

    def configure
      builder.configure(controller)
    end
  end
end
