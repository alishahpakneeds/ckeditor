module CkEditorConcern
  extend ActiveSupport::Concern

  module ClassMethods

  end

  included do
    self.inheritance_column = nil
    before_save :save_ck_editor_type
  end

  def url_content
    # Following is an example according to your attribute you can set
    # if image.present?
    #   image.url
    # end
  end

  def url_thumb
    # Following is an example according to your attribute you can set
    # if image.present?
    #   image.url(:thumb)
    # end
  end

  def filename
    # Following is an example according to your attribute you can set
    # if image.present?
    #   image_file_name
    # end
  end

  def format_created_at
    # Following is an example according to your attribute you can set
    # I18n.l(created_at, format: :default)
  end

  def size
    # Following is an example according to your attribute you can set
    # image_file_size
  end

  #Before save method that will allow all those picutres who saved from  list view of ckeditor
  def save_ck_editor_type
    self.type  = 'Ckeditor::Picture'
  end

end