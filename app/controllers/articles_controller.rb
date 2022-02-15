class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :require_user, except: %i[index show]
  before_action :require_same_user, only: %i[edit update destroy]

  def show; end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def create
    @article = Article.new(article_fields)
    @article.user = current_user
    if @article.save
      flash[:notice] = 'Article was created successfully.'
      redirect_to @article
    else
      render 'new'
    end
  end

  def new
    @article = Article.new
  end

  def edit; end

  def update
    if @article.update(article_fields)
      flash[:notice] = 'Article was updated successfully.'
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    Article.destroy(params[:id])
    redirect_to Article
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_fields
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    return if current_user == @article.user || current_user.admin?

    flash[:alert] = 'You can edit or delete only your own article!'
    redirect_to login_path
  end
end
