class PublicResourcesController < ApplicationController
  layout 'home'
  def index
    @q = PublicResource.ransack(params[:q])
    @public_resources = @q.result.page(params[:page]).per(params[:per] = 25)
  end

  def show
    @public_resource = PublicResource.find(params[:id])
  end

  def new
    @public_resource = PublicResource.new
  end

  def edit
    @public_resource = PublicResource.find(params[:id])
  end

  def create
    @public_resource = PublicResource.new(public_resources_params)
  if @public_resource.save
    redirect_to public_resources_path, :notice => "保存成功！"
  else
    render 'new'
  end
  end

  def destroy
    @public_resource = PublicResource.find(params[:id])
    @public_resource.destroy
    redirect_to public_resources_path
  end

  def import
    @resouce = PublicResource.new
  end

  def import_execl
    PublicResource.import_excel(params[:public_resource][:file])
    redirect_to public_resources_path, :notice => "导入成功！"
  end

  private
  def public_resources_params
    params.require(:public_resource).permit(:area, :institution_name,:level, :genre,:url,:zc,:gt,:js,:cq,:other, :nature,:administrative,:pattern,:cities_share,:center, :center_notice, :remark, :category, attachments_attributes: [:id, :file, :_destroy])
  end

end
