class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  layout "home"
  def index
    @q = Article.where(status: true).ransack(params[:q])
    @articles = @q.result.paginate(:page => params[:page], :per_page => 4)
  end

  def show
    @article.show_count += 1
    @article.save
  end

  private
  def find_article
    @article = Article.find(params[:id])
  end

end
