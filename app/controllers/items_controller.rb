class ItemsController < ApplicationController

  def index
    @items = Item.all  
    @category_options = Category.all.map { |c| [ c.name, c.id ]} 
  end
end
