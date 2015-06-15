require 'archetype/base/interface'

module Archetype
  module Base
    extend ActiveSupport::Concern
    include Interface

    included do
    end

    module ClassMethods
    end
  end
end
