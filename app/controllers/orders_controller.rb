class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def edit
  end

  def show
    @order = Order.find(params[:id])
  end
  
end
