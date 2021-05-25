class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path
  end

  def search
    @article = Article.find_by_title(params[:search_field])
    if @article == nil
      redirect_to root_path, flash: { error: "There are no article with such title!" }
    end
      @title = params[:search_field]
  end

  private
  def article_params
    params.require(:article).permit(:title, :body, :status, images: [])
  end
end