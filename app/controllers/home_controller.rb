class HomeController < ApplicationController

  def index
    @q = Article.where(status: true).ransack(params[:q])
    @articles = @q.result.page(params[:page]).per(params[:per] = 5)
    @pai_artices = Article.where(status: true).order("show_count desc").limit(6)
    @xin_articles = Article.where(status: true).order("created_at desc").limit(6)
    @tj_articles = Article.where(status: true, tj: true).order("created_at desc").limit(6)
  end

  def search
  end
end
