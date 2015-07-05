module Archetype
  module Attributes
    module Types
      class Uploader < Attribute
        def presenter_class
          Presenters::UploaderPresenter
        end

        def filename(object)
          File.basename from(object).to_s
        end
      end
    end
  end
end
