class Ckeditor::PicturesController < Ckeditor::ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  include Ckeditor::ApplicationHelper

  def index
    @pictures = Ckeditor.picture_adapter.find_all(ckeditor_pictures_scope)
    if params[:q].present?
      if Ckeditor.picture_model_attribute.present?
        @pictures = @pictures.where(["data_file_name LIKE ? OR  #{Ckeditor.picture_model_attribute.to_s}_file_name LIKE ? ","%#{params[:q]}%","%#{params[:q]}%"])
      else
        @pictures = @pictures.where(['data_file_name LIKE ? ',"%#{params[:q]}%"])
      end

    end

    @pictures = Ckeditor::Paginatable.new(@pictures).page(params[:page])

    #Other picures that not saved from ckeditor

    @rest_of_images_groups = Ckeditor.system_attachment_model.where(['id IN (?)',fetched_picture_ids(@pictures.scoped)]).group_by(&:id)


    respond_to do |format|
      format.html { render :layout => @pictures.first_page? }
    end
  end

  def create
    @picture = Ckeditor.picture_model.new


    respond_with_asset(@picture)
  end

  def destroy
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to pictures_path }
      format.json { render :nothing => true, :status => 204 }
    end
  end

  protected

    def find_asset
      @picture = Ckeditor.picture_adapter.get!(params[:id])
    end

    def authorize_resource
      model = (@picture || Ckeditor.picture_model)
      @authorization_adapter.try(:authorize, params[:action], model)
    end
end
