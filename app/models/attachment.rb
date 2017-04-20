class Attachment < ApplicationRecord
  belongs_to :attachmentable, optional: true, polymorphic: true, touch: true

  mount_uploader :file, FileUploader
end
