class ItemsController < ApplicationController

  def index
    @items = Item.all
    @items = Category.find(params[:category][:id]).items if params[:category].present?
    @category_options = Category.all.map { |c| [ c.name, c.id ]} 
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "Item successfully created"
      redirect_to item_path(@item)
    else
      flash.now[:notice] = "Wrong values"
      render :new
    end
  end

  protected

  def item_params
    params.require(:item).permit(:title, :description, :price)
  end
end
