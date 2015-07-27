module Archetype
  module Attributes
    module Presenters
      class UploaderPresenter < AttributePresenter
        def short_format(object)
          if thumb = thumb_from(object)
            h.image_tag(thumb, width: 50)
          else
            filename(object)
          end
        end

        def field(form, object=nil)
          SimpleForm::Uploader.new(self, form, object)
        end

        def thumb_from(object)
          uploader = from(object)
          key = %i(admin_thumb thumb thumbnail extra-small xs small).find{|k| uploader.respond_to?(k) && uploader.send(k).present? }
          key ? uploader.send(key) : nil
        end
      end
    end
  end
end
