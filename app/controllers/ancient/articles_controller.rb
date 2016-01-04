class Ancient::ArticlesController < ApplicationController
before_action :find_article, only: [:show, :edit, :update, :destroy]
  layout "home"
  def index
    @q = Article.ransack(params[:q])
    @articles = @q.result.paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

   def new
     @article = Article.new
   end

   def create
     @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "操作成功"
      redirect_to ancient_articles_path
    else
      render :new
    end
   end

   def update
     if @article.update_attributes(article_params)
       flash[:notice] = "操作成功"
     else
       flash[:notice] = "操作失败"
     end
   end

   def destroy
   end

   private
   def find_article
     @article = Article.find(params[:id])
   end

   def article_params
     params.require(:article).permit(:title, :content, :status)
   end
end
