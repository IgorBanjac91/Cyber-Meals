class OrdersController < ApplicationController

  def index
    if params[:status].present?
      if params[:status] == "all"
        @orders = Order.all
      else
        @orders = Order.where(user_id: current_user.id, status: params[:status]) 
      end
    else
      @orders = current_user.orders
    end
  end

  def edit
  end

  def show
    @order = Order.find(params[:id])
  end
  
end
