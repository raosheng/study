class PublicResourcesController < ApplicationController
  layout 'home'
  def index
    @public_resources = PublicResource.all
  end

  def show
    @public_resources = PublicResource.find(params[:id])
  end

  def new
    @public_resources = PublicResource.new
  end

  def create
    @public_resources = PublicResource.new(public_resources_params)
  end

  private
  def public_resources_params
    params.require(:public_resource).permit(:area, :institution_name, :level, :genre, :url)
  end

end
