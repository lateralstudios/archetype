module Archetype
  module Attributes
    module Types
      class Uploader < Attribute
        def filename(object)
          File.basename from(object).to_s
        end
      end
    end
  end
end
