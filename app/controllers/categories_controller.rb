class CategoriesController < ApplicationController
before_action :only_admin

  def index
    @categories = Category.all
    @category = Category.new
  end

  def edit
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      redirect_to categories_path
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to categories_path
    end
  end

  protected 

  def category_params
    params.require(:category).permit(:name)
  end
end
