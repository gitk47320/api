class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    render json: { status: 'SUCCESS', message: 'Loaded Articles', articles: @articles }
  end

  def show
    @article = Article.find(params[:id])
    render json: { status: 'SUCCESS', message: "Loaded Article#{@article.id}", article: @article }
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      render json: { status: 'SUCCESS',  article: @article }
    else
      render json: { status: 'ERROR', article: article.errors }
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    if @article.save
      render json: { status: 'SUCCESS', article: @article }
    else
      render json: { status: 'ERROR', article: article.errors }
    end
  end

  def destroy
    if Article.find(params[:id]).destroy
      render json: { status: 'SUCCESS', message: "Deleted article!"}
    else
      render json: { status: 'ERROR', message: "Deleted false" }
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :content)
  end
end
