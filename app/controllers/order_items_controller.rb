class OrderItemsController < ApplicationController
  before_action :load_order, only: [:create]
  before_action :check_item, only: [:create]
  before_action :set_order_item, except: [:create]

  def edit
  end
  
  def show
  end

  def create
    @order_item = @order.order_items.find_or_initialize_by(item_id: params[:item_id])

    if @order_item.new_record?
      @order_item.quantity = 1
    else
      @order_item.quantity += 1
    end

    if @order_item.save
      redirect_to order_path(@order_item.order)
    end
  end

  def update
    @order_item.update_attribute(:quantity, params[:order_item][:quantity])
    redirect_to order_path(@order_item.order)
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.delete
    redirect_to order_path(params[:order_id])
  end

  protected

    def check_item
      @item = Item.find(params[:item_id])
      if @item.retired 
        flash[:notice] = "You cannot add #{@item.title}, item retired from the menu" 
        redirect_to root_path
      end
    end

    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end
    
end
