class PublicResourcesController < ApplicationController
  layout 'home'
  def index
    @public_resources = PublicResource.all
  end

  def show
    @public_resource = PublicResource.find(params[:id])
  end

  def new
    @public_resource = PublicResource.new
  end

  def create
    @public_resource = PublicResource.new(public_resources_params)
    @public_resource.save
  end

  private
  def public_resources_params
    params.require(:public_resource).permit(:area, :institution_name,:level, :genre,:url,:zc,:gt,:js,:cq,:other, :nature,:administrative,:pattern,:cities_share,:center, :center_notice, :remark, attachments_attributes: [:id, :file, :_destroy])
  end

end
