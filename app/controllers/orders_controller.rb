class OrdersController < ApplicationController
  before_action :order_belonging, only: [:show, :edit]

  def edit
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_belonging
    load_order
    order = Order.find(params[:id])
    if user_signed_in?
      return if current_user.orders.include?(order)
      redirect_to root_path, notice: "Not your order"
    else
      return if order == @order
      redirect_to root_path, notice: "Not your order"
    end
  end
  
end
