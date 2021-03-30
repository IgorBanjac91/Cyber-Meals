class MenusController < ApplicationController
  before_action :load_order, only: [:create]


  def new
    @menu = Menu.new

    @main_dishes = Category.includes(:items).where(name: "Main Dish")[0].items
    @appetaizers = Category.includes(:items).where(name: "Appetaizer")[0].items
    @desserts = Category.includes(:items).where(name: "Dessert")[0].items
    @drinks = Category.includes(:items).where(name: "Drink")[0].items
  end

  def create
    @menu = @order.menus.build(quantity: 1)
    items_ids = params[:menu].values
    @menu.items << Item.where(id: items_ids)
    @menu.format_description
    @menu.calculate_price
    if @menu.save
      flash[:notice] = "Menu added to order"
      redirect_to order_path(@order)
    else
      pp @menu.errors
      flash[:alert] = "Somenthing went wrong"
      redirect_to new_menu_path
    end
  end

  def edit

  end

  protected

  def menu_params
    params.require(:menu).permit(:appetaizer_id, :main_dish_id, :dessert_id, :drink_id)
  end
end
