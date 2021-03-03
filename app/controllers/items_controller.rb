class ItemsController < ApplicationController
  before_action :only_admin, except: [:index, :show]

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

  def item_params
    params.require(:item).permit(:title, :description, :price)
  end

  def only_admin
    authenticate_user!   
    if user_signed_in?
      redirect_to root_path unless current_user.admin
    end
  end
end
