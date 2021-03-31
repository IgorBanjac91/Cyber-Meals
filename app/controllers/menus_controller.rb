class MenusController < ApplicationController
  before_action :load_order, only: [:create, :update, :destroy]
  before_action :query_items, only: [:new, :edit]
  before_action :set_menu, only: [:edit, :update, :destroy]


  def new
    @menu = Menu.new
  end

  def create
    @menu = @order.menus.build(quantity: 1)
    items_ids = params[:menu][:item_ids].values
    @menu.items << Item.where(id: items_ids)
    @menu.quntity = params[:menu][:quantity]
    @menu.format_description
    @menu.calculate_price
    if @menu.save
      flash[:notice] = "Menu added to order"
      redirect_to order_path(@order)
    else
      flash[:alert] = "Somenthing went wrong"
      redirect_to new_menu_path
    end
  end

  def edit
  end
  
  def update
    items_ids = params[:menu][:item_ids].values
    @menu.update(items: Item.where(id: items_ids), quantity: params[:menu][:quantity])
    redirect_to order_path(@order)
  end

  def destroy
    @menu.destroy
    redirect_to order_path(@order)
  end
  
  protected
  
  def menu_params
    params.require(:menu).permit(:quantity, item_ids: [:appetaizer_id, :main_dish_id, :dessert_id, :drink_id])
  end
  
  def query_items
    @main_dishes = Category.includes(:items).where(name: "Main Dish")[0].items
    @appetaizers = Category.includes(:items).where(name: "Appetaizer")[0].items
    @desserts = Category.includes(:items).where(name: "Dessert")[0].items
    @drinks = Category.includes(:items).where(name: "Drink")[0].items
  end
  
  def set_menu
    @menu = Menu.find(params[:id])
  end
  
end
