class ItemsController < ApplicationController
  before_action :only_admin, only: %i{edit update create new}
  before_action :add_category, only: [:update]

  def index
    @items = Item.all
    @items = Category.find(params[:category][:id]).items if params[:category].present?
    @category_options = Category.all.map { |c| [ c.name, c.id ]} 
  end

  def show
    @item = Item.find(params[:id])
    @categories = Category.all.map { |c| [c.name, c.id] }
    @categorizations = @item.categorizations
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

  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id]) 
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end


  protected

  def add_category
    unless params[:category].nil?
      @item = Item.find(params[:id])
      category = Category.find(params[:category][:id])
      @item.categories << category
      redirect_to item_path(@item)
    end
  end

  def item_params
    params.require(:item).permit(:title, :description, :price, :category_ids => [], :image, :image_cache)
  end

end
