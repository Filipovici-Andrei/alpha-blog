class CategoriesController < ApplicationController
  before_action :require_admin, except: %i[index show]
  before_action :set_category, except: %i[new create index]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, notice: 'Category successfully created!'
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Category name updated successfully.'
      redirect_to @category
    else
      render 'edit'
    end
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    return if logged_in? && current_user.admin?

    flash[:alert] = 'Only admins can perform this action!'
    redirect_to categories_path
  end

  def set_category
    @category = Category.find(params[:id])
  end
end