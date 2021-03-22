class DashboardController < ApplicationController

  def items 
    @items = Item.all.includes(:categories)
  end

  def index
    @statuses = Order.select(:status).distinct.where.not(status: "new")
    if params[:status].present?
      @orders = Order.where(status: params[:status] )
    else
      @orders = Order.where.not(status: "new").order(:status).reverse
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end
