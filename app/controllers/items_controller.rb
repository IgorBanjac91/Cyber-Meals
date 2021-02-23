class ItemsController < ApplicationController

  def index
    @items = Item.all
    @items = Category.find(params[:category][:id]).items if params[:category].present?
    @category_options = Category.all.map { |c| [ c.name, c.id ]} 
  end
  
  
end
